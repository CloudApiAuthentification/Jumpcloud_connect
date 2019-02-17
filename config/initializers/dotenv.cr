require "dotenv"

file_path = ENV.fetch("DOTENV") { ".env" }
Dotenv.load(path: file_path)
