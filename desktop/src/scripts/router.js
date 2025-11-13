document.addEventListener('DOMContentLoaded', () => {
    const navLinks = document.querySelectorAll('.nav-item');
    const mainContent = document.getElementById('main-content');

    const loadPage = async (page) => {
        try {
            const response = await fetch(`${page}.html`);
            if (!response.ok) {
                throw new Error('Sayfa yüklenemedi.');
            }
            const content = await response.text();
            mainContent.innerHTML = content;
        } catch (error) {
            mainContent.innerHTML = `<p>Hata: ${error.message}</p>`;
        }
    };

    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const page = link.dataset.page;

            navLinks.forEach(nav => nav.classList.remove('active'));
            link.classList.add('active');

            loadPage(page);
        });
    });

    // Load default page
    loadPage('dashboard');
});
