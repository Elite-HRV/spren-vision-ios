String getProgressText(int progress) {
  String def = 'Place your fingertip over the rear-facing camera lens.';
  if (progress <= 0) {
    return def;
  } else if (progress > 0 && progress <= 10) {
    return 'Detecting your pulse. Keep your hand still and apply gentle pressure...';
  } else if (progress > 10 && progress <= 25) {
    return 'Measuring your heart rate. Please relax and hold still...';
  } else if (progress > 25 && progress <= 40) {
    return 'Detecting the imperceptible patterns in your heart beats...';
  } else if (progress > 40 && progress <= 60) {
    return 'Scanning your nervous system. Please hold still...';
  } else if (progress > 60 && progress <= 80) {
    return 'Extracting your respiration patterns...';
  } else if (progress > 80 && progress <= 99) {
    return 'Almost there...';
  } else if (progress >= 100) {
    return 'Measurement complete!';
  }
  return def;
}
