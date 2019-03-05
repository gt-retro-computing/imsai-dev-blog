all: build upload
build: 
	hugo
upload:
	rsync -a --delete public/ la3:/var/www/imsai.dev/public_html/

.PHONY: build upload
