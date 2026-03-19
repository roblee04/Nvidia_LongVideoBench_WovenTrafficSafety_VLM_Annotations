# VLM Annotations for WTS based dataset for NVIDIA LongVideoBenchmark
**Author:** Robin Lee  

![Project Header/Overview](image(1).png)

##  Methods
Currently, this serves as a baseline VLM Annotation method. It provides a description of an accident or near-accident given a clip of the video (including bounding boxes).

It utilizes:
* **Qwen3 VL Thinking:** For inference and spatial information extraction.
* **YOLOv8 + DeepSORT:** For Bounding Box prediction and ReID.
* **Accident Detection:** Triggered upon bounding box intercepts.

<br>

##  Running
1.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```
2.  Run the tracking module: `tracking.ipynb`
3.  Run the analysis module: `video_understanding.ipynb`

<br><br>

# Deeper Dive

## VLM Technical Stack
* **Model:** [Qwen 3 VL AWQ 35b Thinking](https://arxiv.org/abs/2511.21631)
    * Large context window and native temporal information.
    * Optimized with **Chunked Prefill** and **Speculative Decoding**.
* **Inference Engine:** [vLLM](https://github.com/vllm-project/vllm) — best-in-class for this specific task.

## 🎯 Project Objectives
* **Accurate Labelling:** Create precise descriptions of parallel traffic views per Nvidia requirements.
* **Granular Event Mapping:** Generate multiple descriptions based on specific traffic events.
* *Note: Checked portions in source represent tasks already completed by me.*

## 💡 Intuition
Standard "straight" inference often fails for accidents/near-accidents. Success requires:
1.  **Spatial Context:** Layout and positioning. ✅
2.  **Event Logic:** What occurred and at what timestamp. ✅
3.  **Temporal Data:** Movement over time.

## 🗺️ Scene Information
To avoid reverse-engineering complex IsaacSim asset trees, we utilize:
* **Basic Spatial Data:** VLM-generated descriptions of actors (people/cars) and environment. ✅
* **Augmented Vision:** Provide a **Bird’s Eye View (BEV)** or simplified wireframe as a second input to ground relative distances.
* **Telemetry Injection:** Provide vehicle velocity, brake pressure, and steering angle as a text-table in the prompt.

## 🚗 Events Information
* **Detection:** Extract bounding boxes via **YOLOv8XL** and perform **Re-ID**. ✅
* **Collision Heuristics:** Identify intersections of car and person bounding boxes. ✅
* **Multi-View Verification:** Use multiple views to confirm accidents (vs. simple occlusion).
* **Future Work:** Consider a lightweight temporal model (1D-CNN or Transformer) on top of coordinates to flag "aggressive maneuvering" before VLM processing.
* **Ambiguity Handling:** For near-misses, run the VLM with varied temperature settings or system prompts for consensus.

## 📝 Prompting Strategies
* **Structured Generation:** Use vLLM’s guided decoding (via `outlines` or `lm-format-enforcer`) once the Nvidia output schema is finalized.
* **Spatial Chain of Thought:** Provide extra context during reasoning to improve accuracy.
* **Vector Map Context:** Feed textual map data (e.g., Lanelet2 or OpenDRIVE) to define intersection rules (e.g., "Lane 1 is left-turn only").)
