FROM tensorflow/serving:2.12.1-gpu

COPY /saved_models /models/funne

ENV MODEL_NAME=funne
