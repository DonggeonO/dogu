const writePostButton = document.getElementById('writePostButton');
const modalContainer = document.querySelector('.modal_container');
const confirmButton = document.getElementById('confirm');
const postList = document.getElementById('postList');
const upIcon = document.querySelector('.up');
const close = document.getElementById('close');

const MAX_POSTS = 20; // 최대 게시글 수

// 모달 열기 함수
function openModal() {
    modalContainer.style.display = 'block';
}

// 모달 닫기 함수
function closeModal() {
    modalContainer.style.display = 'none';
    // 입력 필드 초기화
    document.querySelector('.modal_box input[type="text"]').value = '';
    document.querySelectorAll('.modal_box input[type="text"]')[1].value = '';
}

// 게시글 목록 초기화 및 로드
function loadPosts() {
    const posts = JSON.parse(localStorage.getItem('posts')) || [];
    postList.innerHTML = ''; // 기존 목록 초기화
    posts.forEach((post, index) => {
        const newRow = document.createElement('tr');
        newRow.innerHTML = `
            <td>${index + 1}</td>
            <td>${post.title}</td>
            <td>${post.author}</td>
            <td>0</td>
        `;
        postList.appendChild(newRow);
    });
}

// 글쓰기 버튼 클릭 시 모달 열기
writePostButton.addEventListener('click', openModal);

// 확인 버튼 클릭 시 게시글 추가
confirmButton.addEventListener('click', () => {
    const author = document.querySelector('.modal_box input[type="text"]').value;
    const title = document.querySelectorAll('.modal_box input[type="text"]')[1].value;

    // 새 게시글 생성
    if (author && title) {
        const posts = JSON.parse(localStorage.getItem('posts')) || [];
        if (posts.length < MAX_POSTS) { // 현재 게시글 수가 최대 수보다 적을 때
            const newPost = { author, title };
            posts.push(newPost); // 새 게시글 추가
            localStorage.setItem('posts', JSON.stringify(posts)); // 로컬 스토리지에 저장
            loadPosts(); // 게시글 목록 업데이트
            closeModal();
        } else {
            alert('게시글 수는 20개를 초과할 수 없습니다.'); // 최대 게시글 수 초과 시 경고
        }
    } else {
        alert('작성자와 제목을 모두 입력해주세요.');
    }
});

// 모달 창 X 표시 클릭 시 모달 닫기
close.addEventListener('click', (event) => {
    if (event.target === close) {
        closeModal();
    }
});

// 페이지 로드 시 게시글 목록 불러오기
window.addEventListener('load', loadPosts);

// 맨 상단으로 올리는 아이콘
window.addEventListener('scroll', () => {
    if (window.scrollY > 0) {
        upIcon.classList.add('show'); 
    } else {
        upIcon.classList.remove('show'); 
    }
});
