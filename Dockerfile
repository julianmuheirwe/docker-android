FROM ubuntu:16.04



# ------------------------------------------------------

# --- Update Ubuntu



RUN apt-get update 



# ------------------------------------------------------

# --- Install Utility Programs



RUN apt-get install -y unzip wget curl



# ------------------------------------------------------

# --- Install JDK



RUN apt-get install -y openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64



# ------------------------------------------------------

# --- Install Gradle



RUN wget https://downloads.gradle.org/distributions/gradle-5.4.1-bin.zip

RUN mkdir /opt/gradle

RUN unzip -d /opt/gradle gradle-5.4.1-bin.zip

ENV GRADLE_HOME /opt/gradle/gradle-5.4.1

ENV PATH ${PATH}:${GRADLE_HOME}/bin



# ------------------------------------------------------

# --- Install Android



# --- dependencies

RUN apt-get install -y libbz2-1.0 lib32z1 lib32ncurses5 lib32stdc++6



# --- sdk

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip 

RUN mkdir /opt/android-sdk-linux

RUN unzip -d /opt/android-sdk-linux sdk-tools-linux-3859397.zip

RUN chown -R root:root /opt/android-sdk-linux

ENV ANDROID_HOME /opt/android-sdk-linux

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin



# --- install platform and build-tools

RUN yes | sdkmanager --verbose --licenses

RUN echo "y" | sdkmanager --verbose "patcher;v4" "tools" "platforms;android-27" "platforms;android-28" "platforms;android-29" "build-tools;27.0.3" "build-tools;29.0.2" "extras;android;m2repository" "extras;google;google_play_services" "extras;google;m2repository" "extras;google;market_apk_expansion" "extras;google;market_licensing" "extras;google;webdriver" "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"



# ------------------------------------------------------

# --- Install NodeJS



RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get install -y nodejs build-essential



# ------------------------------------------------------

# --- Clean up

RUN rm gradle-5.4.1-bin.zip

RUN rm sdk-tools-linux-3859397.zip

RUN apt-get clean