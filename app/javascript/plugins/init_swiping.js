import Swiper, {
    SwiperPluginLazyload,
    SwiperPluginPagination
} from 'tiny-swiper'

const initSwiping = () => {
  Swiper.use([ SwiperPluginLazyload, SwiperPluginPagination ])
  const swipers = document.querySelectorAll(".favorite-card.swiper-container")
  swipers.forEach((element) => {
    const swiper = new Swiper(element, {
      initialSlide: 1
    })
    swiper.on("after-slide",(newIndex, instance) => {

      const slide = element.querySelectorAll(".swiper-slide")[newIndex]
      const button = slide.querySelector(".action")
      if (button) {
        button.click()
      }
    })
  })

}

export { initSwiping }

