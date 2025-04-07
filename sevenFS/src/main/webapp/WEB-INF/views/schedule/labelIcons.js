// 아이콘 HTML을 생성하는 함수
createIcon = function(type, color) {
    let style = 'display: inline-block; width: 12px; height: 12px; margin-right: 8px;';
    
    if (type === 'circle') {
        style += 'border-radius: 50%;';
    } else {
        style += 'border-radius: 0;';
    }
    
    style += 'background-color: ' + color + ';';
    
    return '<span style="' + style + '"></span>';
}

// DOM 요소로 아이콘 생성하는 함수
function appendIcon(parentElement, type, color) {
    const iconSpan = document.createElement('span');
    iconSpan.style.display = 'inline-block';
    iconSpan.style.width = '12px';
    iconSpan.style.height = '12px';
    iconSpan.style.marginRight = '8px';
    iconSpan.style.backgroundColor = color;
    
    if (type === 'circle') {
        iconSpan.style.borderRadius = '50%';
    }
    
    parentElement.appendChild(iconSpan);
    return iconSpan;
}

// 아이콘 객체 (더 복잡한 구현을 위해)
const IconUtils = {
    createIcon: createIcon,
    appendIcon: appendIcon,
    
    // 미리 정의된 아이콘 타입
    iconTypes: {
        ALL: { type: 'circle', color: '#808080' },
        MEETING: { type: 'circle', color: '#4285F4' },
        DEPARTMENT: { type: 'square', color: '#EA4335' },
        PERSONAL: { type: 'circle', color: '#34A853' }
    }
};