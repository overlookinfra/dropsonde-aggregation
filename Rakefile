require 'json'
require "google/cloud/bigquery"

task :default do
  system("rake -T")
end

desc "Run all data aggregation queries"
task 'sync' do
  unless ENV.include?('BQ_SOURCE_CREDENTIALS')
    raise "Please export keyfile json contents as the `BQ_SOURCE_CREDENTIALS` environment variable"
  end
  unless ENV.include?('BQ_DEST_CREDENTIALS')
    raise "Please export keyfile json contents as the `BQ_DEST_CREDENTIALS` environment variable"
  end

  source = Google::Cloud::Bigquery.new(
              :project_id  => 'bto-dataops-datalake-prod',
              :credentials => ENV['BQ_SOURCE_CREDENTIALS']
            ).dataset('dujour')
  raise "There is a problem with BQ_SOURCE_CREDENTIALS" if source.nil?

  dest = Google::Cloud::Bigquery.new(
              :project_id  => 'dataops-puppet-public-data',
              :credentials => ENV['BQ_DEST_CREDENTIALS']
            ).dataset('aggregated')
  raise "There is a problem with BQ_DEST_CREDENTIALS" if dest.nil?

  Dir.glob('*.sql').each do |file|
    query = File.read(file)
    table = File.basename(file, '.sql')

    begin
      job = source.query_job(query,
                            :write => 'truncate',
                            :table => dest.table(table, :skip_lookup => true))
      job.wait_until_done!
    rescue => e
      puts "Google Cloud error (#{table}): #{e.message}"
    end
  end

end
