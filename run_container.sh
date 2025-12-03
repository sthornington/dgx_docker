docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864  --name fastai -p 8888:8888 \
    -v $HOME/.cache:/home/sthornington/.cache \
    -v ~/projects/fastai:/fastai fastai:latest
