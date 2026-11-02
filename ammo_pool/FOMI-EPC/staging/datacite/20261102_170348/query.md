# DataCite API 检索简报 | 中国水电三局 海外 大坝施工

本件为渠道普查纳管 (1025令) 新接入的 DataCite API 渠道一次引擎运行的实测收割面。内容=命中条目的标题、元信息与摘要/描述摘录 (cred=data, 结构化一手元数据面), 数字均引擎实测零手填。

- 检索词: 中国水电三局 海外 大坝施工
- 引擎: DataCite API (engine=datacite) | 采集: 2026-11-02 17:04
- 通道: HTTP 200 via direct | https://api.datacite.org/dois

---

## ESPnet2 pretrained model, Emiru Tsunoo/aishell_asr_train_asr_streaming_transformer_raw_zh_char_sp_valid.acc.ave, fs=16k, lang=zh

*Zenodo | 2021 | Other*

原文: https://zenodo.org/record/4604023

**摘要/描述摘录:**
> This model was trained by Emiru Tsunoo using aishell recipe in espnet. <strong>Python API</strong><pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong><pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout 006a7f71394510b04817aaa4593dda2ae6f6d508 pip install -e . cd egs2/aishell/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model Emiru Tsunoo/aishell_asr_train_asr_streaming_transformer_raw_zh_char_sp_valid.acc.ave</code> </pre> <strong>Results</strong><pre><code> # RESULTS ## Environments - date: `Sun Feb 21 01:15:01 JST 2021` - python version: `3.8.5 (default, Sep 4 2020, 07:30:14) [GCC 7.3.0]` - espnet version: `espnet 0.9.7` - pytorch version: `pytorch 1.4.0` - Git hash: `006a7f71394510b04817aaa4593dda2ae6f6d508` - Commit date: `Thu Feb 18 10:27:42 2021 +0900` ## asr_train_asr_streaming_transformer_raw_zh_char_sp ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/dev|14326|14326|57.8|42.2|0.0|0.0|42.2|42.2| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/test|7176|7176|56.2|43.8|0.0|0.0|43.8|43.8| ### CER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/dev|

## ESPnet2 pretrained model, kamo-naoyuki/hkust_asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp_valid.acc.ave, fs=16k, lang=zh

*Zenodo | 2021 | Other*

原文: https://zenodo.org/record/4430974

**摘要/描述摘录:**
> This model was trained by kamo-naoyuki using hkust recipe in espnet. <strong>Python API</strong><pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong><pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout db7dfea809ef919332bd28c392b78378a8df5a77 pip install -e . cd egs2/hkust/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model kamo-naoyuki/hkust_asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp_valid.acc.ave</code> </pre> <strong>Results</strong><pre><code> # RESULTS ## Environments - date: `Mon Jan 11 08:44:15 JST 2021` - python version: `3.8.5 (default, Sep 4 2020, 07:30:14) [GCC 7.3.0]` - espnet version: `espnet 0.9.6` - pytorch version: `pytorch 1.4.0` - Git hash: `db7dfea809ef919332bd28c392b78378a8df5a77` - Commit date: `Mon Jan 4 09:44:09 2021 +0900` ## asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_lm_lm_train_lm_transformer_zh_char_optim_conflr0.001_scheduler_confwarmup_steps25000_batch_bins3000000_accum_grad1_valid.loss.ave_asr_model_valid.acc.ave/dev|5413|5240|30.7|69.1|0.2|0.4|69.7|67.4| |decode_lm_lm_train_lm_transformer_zh_char_optim_conflr0.001_scheduler_confwarmup_steps25000_batch_bins3000000_accum_grad8_valid.loss.ave_asr_model_valid.acc.ave/

## ESPnet2 pretrained model, vectominist/seame_asr_conformer_ar_valid.acc.ave, fs=16k, lang=noinfo

*Zenodo | 2022 | Other*

原文: https://zenodo.org/record/5845306

**摘要/描述摘录:**
> This model was trained by vectominist using seame recipe in espnet. <strong>Python API</strong> <pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong> <pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout cddeeef1933ce4c1552e9d2e1af5bb3c60ad74f4 pip install -e . cd egs2/seame/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model vectominist/seame_asr_conformer_ar_valid.acc.ave</code> </pre> <strong>Results</strong> <pre><code class="language-markdown"> # RESULTS ## Environments - date: `Thu Jan 13 17:16:42 CST 2022` - python version: `3.8.12 (default, Oct 12 2021, 13:49:34) [GCC 7.5.0]` - espnet version: `espnet 0.10.6a1` - pytorch version: `pytorch 1.8.1+cu111` - Git hash: `cddeeef1933ce4c1552e9d2e1af5bb3c60ad74f4` - Commit date: `Fri Dec 31 23:16:25 2021 +0900` ## Conformer + Transformer LM ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_lm0.2_ctc0.4_beam30/devman|6531|96737|85.2|11.3|3.5|1.8|16.5|75.5| |decode_lm0.2_ctc0.4_beam30/devsge|5321|54390|79.4|16.0|4.6|2.6|23.2|74.3|</code></pre> <strong>ASR config</strong> <pre><code>config: conf/tuning/train_asr_conformer.yaml print_config: false log_level: INFO dry_run: false iterator_type: sequence output_dir: exp/asr_conformer_ar ngpu: 1 seed: 0 num_workers: 1 num_att_plot: 3 dist_backend: nccl dist_init_method: env:// dist_world_size:

## ESPnet2 pretrained model, vectominist/seame_asr_conformer_ar_valid.acc.ave, fs=16k, lang=noinfo

*Zenodo | 2022 | Other*

原文: https://zenodo.org/record/5845307

**摘要/描述摘录:**
> This model was trained by vectominist using seame recipe in espnet. <strong>Python API</strong> <pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong> <pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout cddeeef1933ce4c1552e9d2e1af5bb3c60ad74f4 pip install -e . cd egs2/seame/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model vectominist/seame_asr_conformer_ar_valid.acc.ave</code> </pre> <strong>Results</strong> <pre><code class="language-markdown"> # RESULTS ## Environments - date: `Thu Jan 13 17:16:42 CST 2022` - python version: `3.8.12 (default, Oct 12 2021, 13:49:34) [GCC 7.5.0]` - espnet version: `espnet 0.10.6a1` - pytorch version: `pytorch 1.8.1+cu111` - Git hash: `cddeeef1933ce4c1552e9d2e1af5bb3c60ad74f4` - Commit date: `Fri Dec 31 23:16:25 2021 +0900` ## Conformer + Transformer LM ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_lm0.2_ctc0.4_beam30/devman|6531|96737|85.2|11.3|3.5|1.8|16.5|75.5| |decode_lm0.2_ctc0.4_beam30/devsge|5321|54390|79.4|16.0|4.6|2.6|23.2|74.3|</code></pre> <strong>ASR config</strong> <pre><code>config: conf/tuning/train_asr_conformer.yaml print_config: false log_level: INFO dry_run: false iterator_type: sequence output_dir: exp/asr_conformer_ar ngpu: 1 seed: 0 num_workers: 1 num_att_plot: 3 dist_backend: nccl dist_init_method: env:// dist_world_size:

## ESPnet2 pretrained model, kamo-naoyuki/hkust_asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp_valid.acc.ave, fs=16k, lang=zh

*Zenodo | 2021 | Other*

原文: https://zenodo.org/record/4430973

**摘要/描述摘录:**
> This model was trained by kamo-naoyuki using hkust recipe in espnet. <strong>Python API</strong><pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong><pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout db7dfea809ef919332bd28c392b78378a8df5a77 pip install -e . cd egs2/hkust/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model kamo-naoyuki/hkust_asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp_valid.acc.ave</code> </pre> <strong>Results</strong><pre><code> # RESULTS ## Environments - date: `Mon Jan 11 08:44:15 JST 2021` - python version: `3.8.5 (default, Sep 4 2020, 07:30:14) [GCC 7.3.0]` - espnet version: `espnet 0.9.6` - pytorch version: `pytorch 1.4.0` - Git hash: `db7dfea809ef919332bd28c392b78378a8df5a77` - Commit date: `Mon Jan 4 09:44:09 2021 +0900` ## asr_train_asr_transformer2_raw_zh_char_batch_bins20000000_ctc_confignore_nan_gradtrue_sp ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_lm_lm_train_lm_transformer_zh_char_optim_conflr0.001_scheduler_confwarmup_steps25000_batch_bins3000000_accum_grad1_valid.loss.ave_asr_model_valid.acc.ave/dev|5413|5240|30.7|69.1|0.2|0.4|69.7|67.4| |decode_lm_lm_train_lm_transformer_zh_char_optim_conflr0.001_scheduler_confwarmup_steps25000_batch_bins3000000_accum_grad8_valid.loss.ave_asr_model_valid.acc.ave/

## ESPnet2 pretrained model, Emiru Tsunoo/aishell_asr_train_asr_streaming_transformer_raw_zh_char_sp_valid.acc.ave, fs=16k, lang=zh

*Zenodo | 2021 | Other*

原文: https://zenodo.org/record/4604022

**摘要/描述摘录:**
> This model was trained by Emiru Tsunoo using aishell recipe in espnet. <strong>Python API</strong><pre><code class="language-python">See https://github.com/espnet/espnet_model_zoo</code></pre> <strong>Evaluate in the recipe</strong><pre><code class="language-bash">git clone https://github.com/espnet/espnet cd espnet git checkout 006a7f71394510b04817aaa4593dda2ae6f6d508 pip install -e . cd egs2/aishell/asr1 ./run.sh --skip_data_prep false --skip_train true --download_model Emiru Tsunoo/aishell_asr_train_asr_streaming_transformer_raw_zh_char_sp_valid.acc.ave</code> </pre> <strong>Results</strong><pre><code> # RESULTS ## Environments - date: `Sun Feb 21 01:15:01 JST 2021` - python version: `3.8.5 (default, Sep 4 2020, 07:30:14) [GCC 7.3.0]` - espnet version: `espnet 0.9.7` - pytorch version: `pytorch 1.4.0` - Git hash: `006a7f71394510b04817aaa4593dda2ae6f6d508` - Commit date: `Thu Feb 18 10:27:42 2021 +0900` ## asr_train_asr_streaming_transformer_raw_zh_char_sp ### WER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/dev|14326|14326|57.8|42.2|0.0|0.0|42.2|42.2| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/test|7176|7176|56.2|43.8|0.0|0.0|43.8|43.8| ### CER |dataset|Snt|Wrd|Corr|Sub|Del|Ins|Err|S.Err| |---|---|---|---|---|---|---|---|---| |decode_asr_streaming_lm_lm_train_lm_zh_char_valid.loss.ave_asr_model_valid.acc.ave/dev|

---

合计 6 条命中 (源状态与代理路径如实记录于台账; 零手填)。