// Defining a data model.
class Response {
  @@dynamic
}

function ExecuteBAML(content: string | image | audio | image[]) -> Response {
  client Llama32_11b_vision
  prompt #"
    {{ _.role('user') }}

    Extract the data from the given content.

    {{ content }}

    {{ ctx.output_format(prefix="Answer with this format:\n") }}
    Your answer MUST be JSON! Wrap your answer in `
  "#
}

// Test the function with a sample resume. Open the VSCode playground to run this.
test amar_resume {
  functions [ExecuteBAML]
  type_builder {
    class Person {
      name string @description("The full name of the individual")
      email string @description("The email address of the individual")
      experience Experience[]
      skills string[]
    }
    
    class Experience {
      position string @description("The role held by the individual")
      company string @description("The company where the experience was gained")
    }

    dynamic class Response {
      result Person
    }
  }
  args {
    content #"
      Amar Nagargoje
      amardnagargoje@gmail.com

      Experience:
      - Founder at AtherAR
      - AI Engineer at Google
      - Software Engineer at Coforge

      Skills:
      - Rust
      - Python
      - Java
      - JavaScript
    "#
  }
}
