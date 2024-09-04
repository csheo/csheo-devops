document.addEventListener("DOMContentLoaded", function() {
  let originalData = []; // 원본 데이터를 저장할 배열

  const table = new Tabulator("#common-code-table", {
    height: "auto",
    layout: "fitColumns",
    dataTree: true,
    dataTreeStartExpanded: false,
    dataTreeChildField: "subCodes",
    dataTreeBranchElement: false,
    dataTreeChildIndent: 10,
    dataTreeCollapseElement: "<i class='bi bi-chevron-down'></i>",
    dataTreeExpandElement: "<i class='bi bi-chevron-right'></i>",
    columns: [
      {title: "Key", field: "codeKey", width: 100},
      {title: "ID", field: "codeId", width: 400},
      {title: "Name", field: "codeName", width: 400}
    ]
  });

  window.applyFilter = function() {
    var key = document.getElementById('search-key').value;
    var id = document.getElementById('search-id').value;
    var name = document.getElementById('search-name').value;

    console.log("Applying filters with values:", { key, id, name });

    if (!key && !id && !name) {
      console.log("No filters applied, resetting data.");
      table.setData([...originalData]); // 원본 데이터로 깊은 복사하여 리셋
      return;
    }

    var filteredData = filterNodes(originalData, {codeKey: key, codeId: id, codeName: name});
    console.log("Filtered Data:", filteredData);
    table.setData(filteredData);
    expandFilteredNodes();
  };

  fetch('/operation/internal/common-codes/all')
    .then(response => response.json())
    .then(data => {
      originalData = data; // 원본 데이터 저장
      table.setData(data);
    })
    .catch(error => console.error('Error loading data: ', error));

  function filterNodes(nodes, filters) {
    return nodes.map(node => ({ ...node })).filter(node => { // 원본 데이터 복사하여 사용
      const selfMatch = filterItem(node, filters);
      if (node.subCodes && node.subCodes.length > 0) {
        const filteredChildren = filterNodes(node.subCodes, filters);
        if (filteredChildren.length > 0) {
          node.subCodes = filteredChildren;
          return true; // 자식 노드 중 조건에 맞는 경우 부모 노드도 포함
        }
      }
      return selfMatch;
    });
  }

  function filterItem(item, filters) {
    return (filters.codeKey ? item.codeKey.toLowerCase().includes(filters.codeKey.toLowerCase()) : true) &&
      (filters.codeId ? item.codeId.toLowerCase().includes(filters.codeId.toLowerCase()) : true) &&
      (filters.codeName ? item.codeName.toLowerCase().includes(filters.codeName.toLowerCase()) : true);
  }

  function expandFilteredNodes() {
    console.log("Expanding filtered nodes.");
    const expandRowRecursively = (row) => {
      row.treeExpand();
      row.getTreeChildren().forEach(childRow => {
        if (childRow.getData().subCodes && childRow.getData().subCodes.length > 0) {
          expandRowRecursively(childRow);
        }
      });
    };

    table.getRows().forEach(row => {
      const rowData = row.getData();
      if (rowData.subCodes && rowData.subCodes.length > 0) {
        console.log("Expanding:", rowData);
        expandRowRecursively(row);
      }
    });
  }
});






