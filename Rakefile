require 'json'
require "google/cloud/bigquery"


def sanitycheck(query)
  if query.match(/FROM\s+(?!\s*(\(|`bto-dataops-datalake-prod.dujour.community_metrics`))/i)
    puts ">> The query appears to access data from the wrong table"
    return false
  end

  true
end


task :default do
  system("rake -T")
end

desc "Run all data aggregation queries"
task 'sync' do
  unless ENV.include?('BQ_CREDENTIALS')
    raise "Please export keyfile json contents as the `BQ_CREDENTIALS` environment variable"
  end

  credentials = JSON.parse(ENV['BQ_CREDENTIALS'])

  source = Google::Cloud::Bigquery.new(
              :project_id  => 'bto-dataops-datalake-prod',
              :credentials => credentials,
            ).dataset('dujour')

  dest = Google::Cloud::Bigquery.new(
              :project_id  => 'dataops-puppet-public-data',
              :credentials => credentials,
            ).dataset('aggregated')

  raise "There is a problem with BQ_CREDENTIALS" if (source.nil? or dest.nil?)

  Dir.glob('*.sql').each do |file|
    query = File.read(file)
    table = File.basename(file, '.sql')

    puts "Generating #{table}..."
    next unless sanitycheck(query)

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

desc "Validate table access"
task 'validate' do
  Dir.glob('*.sql').each do |file|
    query = File.read(file)
    puts "Checking #{file}..."
    sanitycheck(query)
  end
end
