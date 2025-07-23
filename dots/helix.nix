{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        middle-click-paste = false;
        gutters = [
          "line-numbers"
          "diff"
        ];
        bufferline = "multiple";
        color-modes = true;
        trim-final-newlines = true;
      };
      editor.statusline = {
        right = [
          "diagnostics"
          "primary-selection-length"
          "selections"
          "register"
          "position"
          "position-percentage"
          "total-line-numbers"
          "file-indent-style"
          "file-line-ending"
          "file-encoding"
        ];
      };
      editor.cursor-shape = {
        insert = "bar";
        select = "underline";
      };
      editor.indent-guides = {
        render = true;
        skip-levels = 1;
      };
      editor.inline-diagnostics = {
        cursor-line = "hint";
        other-lines = "warning";
      };
    };
  };
}
