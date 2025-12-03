FROM nvcr.io/nvidia/pytorch:25.11-py3
WORKDIR /opt/project/build/
SHELL ["/bin/bash", "-c"]

# Rename the default user and group from ubuntu → sthornington
RUN groupmod -n sthornington ubuntu && \
    usermod -l sthornington -d /home/sthornington -m ubuntu

RUN apt-get update
RUN apt-get install -y curl build-essential graphviz

USER sthornington
WORKDIR /home/sthornington
ENV PATH="/home/sthornington/.local/bin:${PATH}"

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    . "$HOME/.cargo/env" && \
    rustc --version

COPY --chown=sthornington:sthornington ["requirements.txt", "/opt/project/build/"]

RUN pip install --user -r /opt/project/build/requirements.txt

WORKDIR /fastai
ENV KAGGLE_USERNAME=simonthornington \
    KAGGLE_KEY=381aa5573043d07b08d2856dbc3609ac
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--ServerApp.token=", "--ServerApp.password="]
#CMD ["tail", "-f", "/dev/null"]

