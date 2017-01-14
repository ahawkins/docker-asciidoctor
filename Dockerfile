FROM ruby:2.4

MAINTAINER Adam Hawkins <hi@ahawkins.me>

RUN gem install asciidoctor --version 1.5.5 \
	&& gem install asciidoctor-diagram --version 1.5.3 \
	&& gem install asciidoctor-pdf --version 1.5.0.alpha.13 \
	&& gem install asciidoctor-epub3 --version 1.5.0.alpha.6 \
	&& gem install pygments.rb --version 1.1.1 \
	&& gem install coderay --version 1.1.1

CMD [ "asciidoctor" ]
