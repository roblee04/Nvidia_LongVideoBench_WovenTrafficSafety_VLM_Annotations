# VLM Annotations for WTS based dataset for NVIDIA LongVideoBenchmark


# Methods
Currently, this is a baseline VLM Annotation method. It provides a description of an accident / near accident given a clip of the video (with bounding boxes) 

It utilizes:
- Qwen3 VL Thinking
- YOLOv8 + DeepSORT for Bounding Box prediction and ReID



# Running
pip install requirements

Run the tracking.ipynb

Run video_understanding.ipynb