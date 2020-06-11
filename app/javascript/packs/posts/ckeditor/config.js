$(document).on("turbolinks:load", function () {
  ClassicEditor.create(document.querySelector("#editor"), {
    toolbar: {
      items: [
        "heading",
        "|",
        "bold",
        "italic",
        "link",
        "|",
        "fontFamily",
        "fontSize",
        "fontColor",
        "fontBackgroundColor",
        "horizontalLine",
        "|",
        "alignment:left",
        "alignment:center",
        "alignment:right",
        "alignment:justify",
        "|",
        "todoList",
        "bulletedList",
        "numberedList",
        "|",
        "imageUpload",
        "blockQuote",
        "indent",
        "outdent",
        "mediaEmbed",
        "insertTable",
        "|",
        "removeFormat",
        "|",
        "undo",
        "redo"
      ],
    },
    image: {
      toolbar: [
        "imageTextAlternative",
        "|",
        "imageStyle:alignLeft",
        "imageStyle:full",
        "imageStyle:alignRight",
        "imageStyle:alignCenter"
      ],

      styles: ["full", "alignLeft", "alignCenter", "alignRight"],
    },
    fontSize: {
      options: ["10", "12", "14", "16", "18", "20", "24", "28", "32", "36"],
    },
    fontFamily: {
      options: [
        "default",
        "Ubuntu, Arial, sans-serif",
        "Ubuntu Mono, Courier New, Courier, monospace",
        "Arial",
        "Times New Roman",
      ],
    },
    ckfinder: {
      uploadUrl: "Ckfinder/upload",
    },
  })
    .then()
    .catch();
});
