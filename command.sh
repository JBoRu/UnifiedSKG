# finetuning
CUDA_VISIBLE_DEVICES=0,6 python -W ignore -m torch.distributed.launch --nproc_per_node 2 --master_port 1234 train.py \
--seed 2 --cfg Salesforce/T5_base_finetune_compwebq.cfg --run_name T5_base_finetune_compwebq --logging_strategy steps \
--logging_first_step true --logging_steps 4 --evaluation_strategy steps --eval_steps 500 --metric_for_best_model avr \
--greater_is_better true --save_strategy steps --save_steps 500 --save_total_limit 1 --load_best_model_at_end \
--gradient_accumulation_steps 8 --num_train_epochs 400 --adafactor true --learning_rate 5e-5 --do_train --do_eval \
--do_predict --predict_with_generate --output_dir output/T5_base_finetune_compwebq --overwrite_output_dir \
--per_device_train_batch_size 2 --per_device_eval_batch_size 2 --generation_num_beams 4 --generation_max_length 128 \
--input_max_length 1024 --ddp_find_unused_parameters true
# test ft model without kg information input
CUDA_VISIBLE_DEVICES=0,7 python -W ignore -m torch.distributed.launch --nproc_per_node 2 --master_port 1234 train.py \
--seed 2 --cfg Salesforce/T5_base_finetune_compwebq.cfg --run_name T5_base_finetune_compwebq --logging_strategy steps \
--logging_first_step true --logging_steps 4 --evaluation_strategy steps --eval_steps 500 --metric_for_best_model avr \
--greater_is_better true --save_strategy steps --save_steps 500 --save_total_limit 1 --load_best_model_at_end \
--gradient_accumulation_steps 8 --num_train_epochs 400 --adafactor true --learning_rate 5e-5 \
--do_predict --predict_with_generate --output_dir output/T5_base_finetune_compwebq --overwrite_output_dir \
--per_device_train_batch_size 2 --per_device_eval_batch_size 2 --generation_num_beams 4 --generation_max_length 128 \
--input_max_length 1024 --ddp_find_unused_parameters true --load_weights_from output/T5_base_finetune_compwebq/checkpoint-5500
# transfer finetuning model from cwq to wsp
CUDA_VISIBLE_DEVICES=0,6 python -W ignore -m torch.distributed.launch --nproc_per_node 2 --master_port 1234 train.py \
--seed 2 --cfg Salesforce/T5_base_finetune_webqsp.cfg --run_name T5_base_finetune_webqsp --logging_strategy steps \
--logging_first_step true --logging_steps 4 --evaluation_strategy steps --eval_steps 500 --metric_for_best_model avr \
--greater_is_better true --save_strategy steps --save_steps 500 --save_total_limit 1 --load_best_model_at_end \
--gradient_accumulation_steps 8 --num_train_epochs 400 --adafactor true --learning_rate 5e-5 \
--do_predict --predict_with_generate --output_dir output/T5_base_finetune_webqsp --overwrite_output_dir \
--per_device_train_batch_size 2 --per_device_eval_batch_size 16 --generation_num_beams 4 --generation_max_length 128 \
--input_max_length 1024 --ddp_find_unused_parameters true --load_weights_from output/T5_base_finetune_webqsp/checkpoint-5500
# prefix-tuning
CUDA_VISIBLE_DEVICES=0,6 python -W ignore -m torch.distributed.launch --nproc_per_node 2 --master_port 1235 train.py \
--seed 2 --cfg Salesforce/T5_base_prefix_compwebq.cfg --run_name T5_base_prefix_compwebq --logging_strategy steps \
-logging_first_step true --logging_steps 4 --evaluation_strategy steps --eval_steps 500 --metric_for_best_model avr \
--greater_is_better true --save_strategy steps --save_steps 500 --save_total_limit 1 --load_best_model_at_end \
--gradient_accumulation_steps 8 --num_train_epochs 400 --adafactor true --learning_rate 5e-5 --do_train --do_eval \
--do_predict --predict_with_generate --output_dir output/T5_base_prefix_compwebq --overwrite_output_dir \
--per_device_train_batch_size 2 --per_device_eval_batch_size 2 --generation_num_beams 4 --generation_max_length 128 \
--input_max_length 1024 --ddp_find_unused_parameters true
