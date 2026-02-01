import { Controller } from "@hotwired/stimulus"

// Smooth scroll controller for enhanced navigation
export default class extends Controller {
  connect() {
    this.setupSmoothScroll()
  }

  setupSmoothScroll() {
    // Enhanced smooth scrolling for all anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', (e) => {
        const href = anchor.getAttribute('href')
        
        // Skip if it's just "#"
        if (href === '#') return
        
        e.preventDefault()
        
        const targetId = href.substring(1)
        const targetElement = document.getElementById(targetId)
        
        if (targetElement) {
          // Custom smooth scroll with easing
          const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - 100
          const startPosition = window.pageYOffset
          const distance = targetPosition - startPosition
          const duration = 5200 // 5.2 seconds for smooth motion
          let start = null
          
          // Easing function for smooth acceleration/deceleration
          const easeInOutCubic = (t) => {
            return t < 0.5 
              ? 4 * t * t * t 
              : 1 - Math.pow(-2 * t + 2, 3) / 2
          }
          
          const animation = (currentTime) => {
            if (start === null) start = currentTime
            const timeElapsed = currentTime - start
            const progress = Math.min(timeElapsed / duration, 1)
            const ease = easeInOutCubic(progress)
            
            window.scrollTo(0, startPosition + distance * ease)
            
            if (timeElapsed < duration) {
              requestAnimationFrame(animation)
            }
          }
          
          requestAnimationFrame(animation)
        }
      })
    })
  }
}
