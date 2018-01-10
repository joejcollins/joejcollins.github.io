---
layout: post
---

JavaScript on the page.

```javascript
$(function() {
    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: '@Url.Action("ReportData", new {id = Model.Id})',
        data: '{}',
        success: function(siteData) {
            var months = siteData.Months;
            doSomeStuffWithThe(months);
        },
        error: function() {
            alert("Error loading data! Please try again.");
        }
    });
});
```

Method on the controller.


```csharp
public JsonResult ReportData(Guid? id)
{
    Site site = _dataDb.Sites.Find(id);
    var months = site.Months.OrderBy(c => c.MonthTime).ToList();
    site.Months = months;
    return Json(site, JsonRequestBehavior.AllowGet);
}
```