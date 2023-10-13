{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates.cpp_simple = {
      path = ./cpp_simple;
      description = "A simplified c++ project template";
      welcomeText = ''
        # yo
      '';
    };

    templates.default = self.templates.cpp_simple;
  };
}
