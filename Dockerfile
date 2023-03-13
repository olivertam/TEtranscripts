FROM python

#PREAMBLE

WORKDIR /home/genomics
COPY . /home/genomics
RUN cd /home/genomics

RUN apt-get --assume-yes update \
	&& apt-get --assume-yes upgrade

#MAIN

RUN apt-get --assume-yes install r-base

RUN R -e "install.packages('lattice', dependencies=TRUE, repos='http://cran.rstudio.com/')" \
  && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/locfit/locfit_1.5-9.4.tar.gz', repos=NULL, type='source')" \
  && R -e "install.packages('BiocManager', dependencies=TRUE, repos='http://cran.rstudio.com/'); BiocManager::install()" \
	&& R -e "BiocManager::install(\"DESeq2\")" \
	&& pip install pysam \
	&& pip install 'TEtranscripts @ git+https://github.com/olivertam/TEtranscripts@4b95224c222c79872f81af284bdcc2d52ffa25c8'\
	&& rm -rf *.tgz *.tar *.zip \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /tmp/*
