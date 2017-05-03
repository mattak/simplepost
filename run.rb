require 'sinatra'
require 'fileutils'

SAVEDIR = "./public/blobs"

set :public, File.dirname(__FILE__) + '/public'

post '/' do
  if params[:file]
    savepath = "#{SAVEDIR}/#{params[:file][:filename]}"
    FileUtils.mkdir_p(File.dirname(savepath))
    puts params[:file][:tempfile]
    FileUtils.copy(params[:file][:tempfile].path, savepath)
    'OK'
  else
    'NG'
  end
end

get '/' do
  request.env['REQUEST_URI']
  files = Dir.foreach(SAVEDIR)
    .select{|it| File.file?(it) }
    .collect{|it| "#{request.env['REQUEST_URI']}blobs/#{it}" }
  files.join('\n')
end

