FROM zzzcat/dispshell

#
# Chrome & Webdriver
#
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends chromium && \
    pip install --upgrade pip setuptools wheel && \
    # webdriverはなるべく近いバージョンをダウンロード
    pip install chromedriver-binary~=$(chromium --version | perl -pe 's/([^0-9]+)([0-9]+\.[0-9]+).+/$2/g') && \
    echo "*** INSTALLED: chrome & webdriver ***"
#
# 日本語環境
#
ENV LANGUAGE ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
RUN apt-get install -y --no-install-recommends locales && \
    locale-gen ja_JP.UTF-8 && \
    # 日本語フォントをインストール
    apt-get install -y --no-install-recommends fonts-ipafont && \
    echo "*** INSTALLED: ja_JP locale & font ***"

#
# PIP upgrade
#
COPY selenium-requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install -r selenium-requirements.txt && \
    echo "*** INSTALLED: python modules ***"
