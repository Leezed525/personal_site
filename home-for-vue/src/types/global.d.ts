interface Window {
  $toast: {
    show: (text: string, type?: "success" | "error" | "info") => void;
    success: (text: string) => void;
    error: (text: string) => void;
    info: (text: string) => void;
  };
}
