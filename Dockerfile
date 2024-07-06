FROM debian:12.5-slim
FROM alpine:latest


EXPOSE 80
WORKDIR /home

RUN apk add --no-cache --virtual bash curl unzip aspnetcore6-runtime ffmpeg chromium \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /home


RUN curl -L -k -o publish.zip https://github.com/immisterio/Lampac/releases/latest/download/publish.zip \
    && unzip -o publish.zip && rm -f publish.zip && rm -rf merchant \
    && rm -rf runtimes/os* && rm -rf runtimes/win* && rm -rf runtimes/linux-arm runtimes/linux-arm64 runtimes/linux-musl-arm64 runtimes/linux-musl-x64 \
    && touch isdocker

RUN curl -L -k -o minor.zip https://github.com/immisterio/Lampac/releases/latest/download/minor.zip && unzip -o minor.zip && rm -f minor.zip

RUN echo '{"listenport":80,"listenscheme":"https","KnownProxies":[{"ip":"0.0.0.0","prefixLength":0}],"rch":{"enable":true},"typecache":"mem","mikrotik":true,"weblog":true,"serverproxy":{"verifyip":false,"showOrigUri":true,"buffering":{"enable":false}},"pirate_store": false,"dlna":{"enable":false},"puppeteer":{"executablePath":"/usr/bin/chromium"},"LampaWeb":{"autoupdate":false},"online":{"checkOnlineSearch":false},"Rezka":{"host":"https://hdrezka.me","corseu":true,"xrealip":true,"uacdn":"https://prx-ams.ukrtelcdn.net","hls":false},"VDBmovies":{"streamproxy":true},"iRemux":{"streamproxy":false,"geostreamproxy":["UA"],"apn": "https://apn.watch"},"VCDN":{"rhub":true},"Kinobase":{"rhub":true},"Eneyida":{"rhub":true},"Kinoukr":{"rhub":true},"Kodik":{"enable":false},"AnimeGo":{"enable": false},"Animebesst":{"enable": false},"Eporner":{"streamproxy":false},"PornHub":{"enable":false},"Ebalovo":{"enable":false},"Chaturbate":{"enable":false}}' > /home/init.conf

RUN echo '[{"enable":true,"dll":"SISI.dll"},{"enable":true,"dll":"Online.dll"}]' > /home/module/manifest.json

ENTRYPOINT ["dotnet", "Lampac.dll"]
