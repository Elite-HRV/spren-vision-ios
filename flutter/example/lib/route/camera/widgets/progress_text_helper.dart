String getProgressText(int progress) {
  String def = 'Place your fingertip over the rear-facing camera lens.';
  if (progress <= 0) {
    return def;
  } else if (progress > 0 && progress <= 1) {
    return 'Detecting your pulse. Keep your hand still and apply gentle pressure...';
  } else if (progress > 1 && progress <= 15) {
    return 'Measuring your heart rate. Please relax and hold still...';
  } else if (progress > 15 && progress <= 30) {
    return 'Detecting the imperceptible patterns in your heart beats...';
  } else if (progress > 30 && progress <= 50) {
    return 'Scanning your nervous system. Please hold still...';
  } else if (progress > 50 && progress <= 70) {
    return 'Extracting your respiration patterns...';
  } else if (progress > 70 && progress <= 85) {
    return 'Almost there...';
  } else if (progress > 85) {
    return 'Measurement complete!';
  }
  return def;
}
