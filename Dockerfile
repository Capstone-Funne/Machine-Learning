FROM tensorflow/serving:2.12.1-gpu

ENV MODEL_BASE_PATH=/models
ENV MODEL_NAME=funne

COPY /saved_models /models/funne
COPY /models.config /models.config

EXPOSE 8501

RUN echo '#!/bin/bash \n\n\
tensorflow_model_server --port=8500 --rest_api_port=8501 \
--model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} \
--model_config_file=/models.config \
"$@"' > /usr/bin/tf_serving_entrypoint.sh \
&& chmod +x /usr/bin/tf_serving_entrypoint.sh

ENTRYPOINT ["/usr/bin/tf_serving_entrypoint.sh"]
