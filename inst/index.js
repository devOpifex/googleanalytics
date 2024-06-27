$(document).on("shiny:inputchanged", (event) => {
  if (event.name.match(/^.clientdata/)) return;

  gtag("event", event.name, {
    type: event.inputType,
    value: event.value,
    category: "input",
  });
});

$(document).on("shiny:value", (event) => {
  gtag("event", event.name, {
    value: event.value,
    category: "output",
  });
});

$(document).on("shiny:filedownload", (event) => {
  gtag("event", event.name, {});
});

$(document).on("shiny:error", (event) => {
  gtag("event", "error", {
    name: event.name,
    error: event.error,
    category: "error",
  });
});

$(document).on("shiny:visualchange", (event) => {
  const id = $(event.binding.el).attr("id");

  if(!id) return;

  gtag("event", "visualchange", {
    id: id,
    visible: event.visible,
    category: "visualchange",
  });
});

$(document).on("shiny:busy", () => {
  gtag("event", "busy", {});
});

$(document).on("shiny:idle", () => {
  gtag("event", "idle", {});
});

$(() => {
  const navbar = $(document).find(".navbar");
  if (!navbar.length) return;

  $(navbar)
    .find("[data-toggle='tab']")
    .on("click", (event) => {
      gtag("event", "navigation", {
        value: $(event.target).data("value"),
        type: "navigation",
      });
    });
});
