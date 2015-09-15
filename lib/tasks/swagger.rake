namespace :swagger do
  desc "Generate Swagger documentation files"
  task :docs => [:environment] do |t,args|
    results = Swagger::Docs::Generator.write_docs(Swagger::Docs::Config.registered_apis)
    print_results(results)
  end

  desc "Generate Swagger multiple documentation files"
  task multiple_docs: :environment do
    Swagger::Docs::Config.registered_multiple_apis.each do |config|
      results = Swagger::Docs::Generator.write_docs(config)
      print_results(results)
    end
  end

  private
  def print_results(results)
    results.each do |k,v|
      puts "#{k}: #{v[:processed].count} processed / #{v[:skipped].count} skipped"
    end
  end
end
