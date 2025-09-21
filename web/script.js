// Datos simulados basados en tu estudio
const datosIntentos = [
    1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 7, 8, 9, 10,
    1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 5, 5,
    2, 2, 3, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4
];

const datosTiempo = [
    1.2, 1.5, 1.8, 2.1, 2.3, 1.9, 1.7, 2.0, 2.2, 1.6, 1.4, 2.4, 2.6, 1.8, 2.0,
    1.3, 1.6, 1.9, 2.2, 2.5, 1.7, 1.5, 2.1, 2.3, 1.8, 1.4, 2.0, 2.4, 1.6, 1.9,
    2.1, 1.7, 1.5, 2.2, 2.0, 1.8, 1.6, 2.3, 1.9, 1.4, 2.1, 1.7, 2.0, 1.8, 1.5,
    2.2, 1.6, 1.9, 2.1, 1.7, 1.4, 2.0, 1.8, 2.3, 1.5, 1.9, 2.1, 1.6, 1.8, 2.0
];

// Generar datos correlacionados para el scatter plot
const datosCorrelacion = [];
for (let i = 0; i < 100; i++) {
    const intentos = Math.floor(Math.random() * 10) + 1;
    const tiempo = 1.2 + (intentos * 0.15) + (Math.random() * 0.8 - 0.4);
    datosCorrelacion.push({ x: intentos, y: Math.max(0.5, tiempo) });
}

// Datos para boxplot
const tiemposDiestros = [1.8, 1.9, 2.0, 1.7, 2.1, 1.6, 2.2, 1.5, 1.9, 2.0, 1.8, 2.1, 1.7, 1.9, 2.0];
const tiemposZurdos = [2.0, 2.1, 1.9, 2.2, 1.8, 2.3, 1.7, 2.0, 1.9, 2.1, 2.0, 1.8, 2.2, 1.9, 2.0];

// Función para crear histograma de intentos
function crearHistogramaIntentos() {
    const trace = {
        x: datosIntentos,
        type: 'histogram',
        nbinsx: 10,
        marker: {
            color: '#3b82f6',
            opacity: 0.7,
            line: {
                color: '#1e40af',
                width: 1
            }
        },
        name: 'Frecuencia'
    };

    const media = datosIntentos.reduce((a, b) => a + b, 0) / datosIntentos.length;
    
    const layout = {
        title: {
            text: 'Distribución de Intentos hasta el Éxito',
            font: { size: 16, color: '#1f2937' }
        },
        xaxis: {
            title: 'Número de Intentos',
            gridcolor: '#e5e7eb'
        },
        yaxis: {
            title: 'Frecuencia',
            gridcolor: '#e5e7eb'
        },
        shapes: [{
            type: 'line',
            x0: media,
            x1: media,
            y0: 0,
            y1: 1,
            yref: 'paper',
            line: {
                color: '#ef4444',
                width: 2,
                dash: 'dash'
            }
        }],
        annotations: [{
            x: media,
            y: 0.9,
            yref: 'paper',
            text: `Media: ${media.toFixed(2)}`,
            showarrow: true,
            arrowhead: 2,
            arrowcolor: '#ef4444',
            bgcolor: 'white',
            bordercolor: '#ef4444'
        }],
        plot_bgcolor: 'white',
        paper_bgcolor: 'white',
        font: { family: 'Inter, sans-serif' }
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('intentosChart', [trace], layout, config);
}

// Función para crear histograma de tiempo
function crearHistogramaTiempo() {
    const trace = {
        x: datosTiempo,
        type: 'histogram',
        nbinsx: 15,
        marker: {
            color: '#10b981',
            opacity: 0.7,
            line: {
                color: '#059669',
                width: 1
            }
        },
        name: 'Frecuencia'
    };

    const media = datosTiempo.reduce((a, b) => a + b, 0) / datosTiempo.length;
    
    const layout = {
        title: {
            text: 'Distribución de Tiempo de Saque',
            font: { size: 16, color: '#1f2937' }
        },
        xaxis: {
            title: 'Tiempo (segundos)',
            gridcolor: '#e5e7eb'
        },
        yaxis: {
            title: 'Frecuencia',
            gridcolor: '#e5e7eb'
        },
        shapes: [{
            type: 'line',
            x0: media,
            x1: media,
            y0: 0,
            y1: 1,
            yref: 'paper',
            line: {
                color: '#ef4444',
                width: 2,
                dash: 'dash'
            }
        }],
        annotations: [{
            x: media,
            y: 0.9,
            yref: 'paper',
            text: `Media: ${media.toFixed(3)}s`,
            showarrow: true,
            arrowhead: 2,
            arrowcolor: '#ef4444',
            bgcolor: 'white',
            bordercolor: '#ef4444'
        }],
        plot_bgcolor: 'white',
        paper_bgcolor: 'white',
        font: { family: 'Inter, sans-serif' }
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('tiempoChart', [trace], layout, config);
}

// Función para crear gráfico de correlación
function crearGraficoCorrelacion() {
    const trace = {
        x: datosCorrelacion.map(d => d.x),
        y: datosCorrelacion.map(d => d.y),
        mode: 'markers',
        type: 'scatter',
        marker: {
            color: '#8b5cf6',
            size: 8,
            opacity: 0.6
        },
        name: 'Observaciones'
    };

    // Línea de tendencia
    const xValues = datosCorrelacion.map(d => d.x);
    const yValues = datosCorrelacion.map(d => d.y);
    const n = xValues.length;
    const sumX = xValues.reduce((a, b) => a + b, 0);
    const sumY = yValues.reduce((a, b) => a + b, 0);
    const sumXY = xValues.reduce((sum, x, i) => sum + x * yValues[i], 0);
    const sumXX = xValues.reduce((sum, x) => sum + x * x, 0);
    
    const slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    const intercept = (sumY - slope * sumX) / n;
    
    const minX = Math.min(...xValues);
    const maxX = Math.max(...xValues);
    
    const trendline = {
        x: [minX, maxX],
        y: [slope * minX + intercept, slope * maxX + intercept],
        mode: 'lines',
        type: 'scatter',
        line: {
            color: '#ef4444',
            width: 3
        },
        name: 'Línea de tendencia'
    };

    const layout = {
        title: {
            text: 'Relación Intentos vs Tiempo de Saque (r = 0.65)',
            font: { size: 16, color: '#1f2937' }
        },
        xaxis: {
            title: 'Número de Intentos',
            gridcolor: '#e5e7eb'
        },
        yaxis: {
            title: 'Tiempo de Saque (segundos)',
            gridcolor: '#e5e7eb'
        },
        plot_bgcolor: 'white',
        paper_bgcolor: 'white',
        font: { family: 'Inter, sans-serif' },
        showlegend: true
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('correlacionChart', [trace, trendline], layout, config);
}

// Función para crear boxplot
function crearBoxplot() {
    const traceDiestros = {
        y: tiemposDiestros,
        type: 'box',
        name: 'Diestros',
        marker: {
            color: '#3b82f6'
        },
        boxpoints: 'all',
        jitter: 0.3,
        pointpos: -1.8
    };

    const traceZurdos = {
        y: tiemposZurdos,
        type: 'box',
        name: 'Zurdos',
        marker: {
            color: '#f59e0b'
        },
        boxpoints: 'all',
        jitter: 0.3,
        pointpos: -1.8
    };

    const layout = {
        title: {
            text: 'Distribución de Tiempo por Mano Dominante',
            font: { size: 16, color: '#1f2937' }
        },
        yaxis: {
            title: 'Tiempo de Saque (segundos)',
            gridcolor: '#e5e7eb'
        },
        plot_bgcolor: 'white',
        paper_bgcolor: 'white',
        font: { family: 'Inter, sans-serif' }
    };

    const config = {
        responsive: true,
        displayModeBar: false
    };

    Plotly.newPlot('boxplotChart', [traceDiestros, traceZurdos], layout, config);
}

// Navegación suave
function initSmoothScrolling() {
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const headerHeight = document.querySelector('.header').offsetHeight;
                const targetPosition = targetSection.offsetTop - headerHeight - 20;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
}

// Animaciones al hacer scroll
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    const sections = document.querySelectorAll('.section');
    sections.forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';
        section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(section);
    });
}

// Menú móvil
function initMobileMenu() {
    const menuToggle = document.getElementById('menuToggle');
    const nav = document.querySelector('.nav');
    
    menuToggle.addEventListener('click', () => {
        nav.classList.toggle('active');
    });
}

// Actualizar navegación activa
function updateActiveNav() {
    const sections = document.querySelectorAll('.section[id]');
    const navLinks = document.querySelectorAll('.nav-link');
    
    window.addEventListener('scroll', () => {
        const scrollPosition = window.scrollY + 100;
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                navLinks.forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${sectionId}`) {
                        link.classList.add('active');
                    }
                });
            }
        });
    });
}

// Inicializar todo cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', function() {
    // Crear gráficos
    setTimeout(() => {
        crearHistogramaIntentos();
        crearHistogramaTiempo();
        crearGraficoCorrelacion();
        crearBoxplot();
    }, 100);
    
    // Inicializar funcionalidades
    initSmoothScrolling();
    initScrollAnimations();
    initMobileMenu();
    updateActiveNav();
    
    // Hacer los gráficos responsivos
    window.addEventListener('resize', () => {
        Plotly.Plots.resize('intentosChart');
        Plotly.Plots.resize('tiempoChart');
        Plotly.Plots.resize('correlacionChart');
        Plotly.Plots.resize('boxplotChart');
    });
});

// Agregar estilos CSS para navegación activa
const style = document.createElement('style');
style.textContent = `
    .nav-link.active {
        color: var(--primary-color) !important;
    }
    
    .nav-link.active::after {
        width: 100% !important;
    }
    
    @media (max-width: 768px) {
        .nav {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            flex-direction: column;
            padding: 1rem;
            box-shadow: var(--shadow-lg);
            transform: translateY(-100%);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }
        
        .nav.active {
            transform: translateY(0);
            opacity: 1;
            visibility: visible;
        }
        
        .nav-link {
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-color);
        }
        
        .nav-link:last-child {
            border-bottom: none;
        }
    }
`;
document.head.appendChild(style);