{ mkShell, 
  template-lib,
  ...
}:

mkShell {
  name = "template-devshell";
  inputsFrom = [ template-lib ];
  shellHook = ''
    echo "yo"
  '';
}