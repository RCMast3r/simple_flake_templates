{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates.cpp-template = {
      path = ./cpp-template;
      description = "A simplified c++ project template";
      welcomeText = ''
        # yo
      '';
    };

    templates.default = self.templates.cpp-template;
  };
}
