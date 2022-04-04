String getProcessingProgressText(int progress) {
  String def = 'Analyzing autonomic nervous system...';
  if (progress <= 60) {
    return def;
  } else if (progress > 60 && progress < 80) {
    return 'Analyzing baseline trends...';
  } else if (progress >= 80 && progress < 100) {
    return 'Generating personalized insights...';
  } else if (progress >= 100) {
    return 'Complete!';
  }
  return def;
}
