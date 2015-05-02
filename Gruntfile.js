module.exports = function(grunt) {
  "use strict";

  var libFiles = [
    "src/**/*.purs",
    "bower_components/purescript-*/src/**/*.purs",
  ]
  var testsFiles = ["test/**/*.purs"].concat(libFiles)

  grunt.initConfig({
    pscMake: {
      all: { src: libFiles }
    },
    psc: {
      tests: {
        options: {
          main: "Test.Main"
        },
        src: testsFiles,
        dest: "tmp/tests.js"
      }
    },
    dotPsci: {
      src: libFiles
    },
    // pscDocs: {
    //   dataOrd: {
    //     src: "src/Data/Ord.purs",
    //     dest: "docs/Data.Ord.md"
    //   }
    // },
    execute: {
      tests: {
        src: "tmp/tests.js"
      }
    }
  });

  grunt.loadNpmTasks("grunt-purescript");
  grunt.loadNpmTasks("grunt-execute");

  grunt.registerTask("test",    ["psc:tests", "execute:tests"]);
  grunt.registerTask("make",    ["dotPsci", "pscMake"]);
  grunt.registerTask("default", ["make"]);
};
