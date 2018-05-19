FROM ubuntu

RUN apt-get update && apt-get upgrade && apt-get -y install nginx qbittorrent-nox samba

COPY smb_downloads /etc/samba/smb_downloads
RUN cat '/etc/samba/smb_downloads' >> /etc/samba/smb.conf

COPY proxy /etc/nginx/sites-available/proxy

RUN rm /etc/nginx/sites-enabled/default && ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/proxy && nginx -t

EXPOSE 137 138 139 445 80
CMD /etc/init.d/smbd start && qbittorrent-nox --daemon && nginx -g "daemon off;"