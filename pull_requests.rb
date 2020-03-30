require 'json'
require 'net/https'
require 'uri'
require 'pp'


def usage
    puts "auth info. echo -n username:password | base64"
    puts "repository infoinfo. user-foo/repo-helloworld"
    puts "branch_name. pull request destination branch name. exmaple release/foo"
end

unless ARGV.length == 3
  usage
  exit 1
end


$auth_info  = ARGV[0]
repo_name  = ARGV[1]
branch_name = ARGV[2]


query_expression = URI.encode_www_form_component('destination.branch.name = "' + branch_name + '"')

uri = 'https://api.bitbucket.org/2.0/repositories/'+repo_name+'/pullrequests?q='+query_expression

#puts uri

def fetch_pull_request_list(uri)

    url = URI.parse(uri)
    req = Net::HTTP::Get.new(url)
    req['Authorization'] = "Basic #{$auth_info}"
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    res = https.start do |http|
       http.request(req)
    end

    puts res.code
    if res.code == '200'
        results = JSON.load(res.body)
        #pp results
#        puts results['next']

        results['values'].each do|result|
#            puts result['id']
#            puts result['title']
#            puts result["state"]
#            puts result["destination"]["branch"]["name"]
            puts "[#{result['state']}]#{result['title']}"
        end
        if results.key?('next')
            fetch_pull_request_list(results['next'])
        end
    end
end

fetch_pull_request_list(uri)
