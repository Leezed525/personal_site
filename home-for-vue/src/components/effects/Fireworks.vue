<template>
  <canvas
    ref="canvas"
    class="fixed inset-0 pointer-events-none z-[100] transition-opacity duration-1000"
    :class="{ 'opacity-0': shouldFadeOut }"
  ></canvas>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from "vue";

interface Props {
  enabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  enabled: true,
});

const canvas = ref<HTMLCanvasElement | null>(null);
let ctx: CanvasRenderingContext2D | null = null;
let confetti: Confetti[] = [];
let animationId: number;
const shouldFadeOut = ref(false);

interface Confetti {
  x: number;
  y: number;
  rotation: number;
  rotationSpeed: number;
  vx: number;
  vy: number;
  width: number;
  height: number;
  color: string;
  opacity: number;
}

// 彩带颜色 - 使用亮色系
const colors = [
  "#FF69B4", // 粉红
  "#87CEEB", // 天蓝
  "#98FB98", // 浅绿
  "#DDA0DD", // 梅红
  "#F0E68C", // 卡其
  "#FFB6C1", // 浅粉
  "#87CEFA", // 浅天蓝
  "#FFA07A", // 浅鲑鱼色
];

const createConfetti = () => {
  const x = Math.random() * canvas.value!.width;
  const y = canvas.value!.height;

  return {
    x,
    y,
    rotation: Math.random() * 360,
    rotationSpeed: (Math.random() - 0.5) * 2,
    vx: (Math.random() - 0.5) * 3,
    vy: -Math.random() * 15 - 10, // 向上的初始速度
    width: Math.random() * 10 + 5,
    height: Math.random() * 6 + 3,
    color: colors[Math.floor(Math.random() * colors.length)],
    opacity: 1,
  };
};

const drawConfetti = (confetti: Confetti) => {
  if (!ctx) return;

  ctx.save();
  ctx.translate(confetti.x, confetti.y);
  ctx.rotate((confetti.rotation * Math.PI) / 180);
  ctx.globalAlpha = confetti.opacity;

  ctx.fillStyle = confetti.color;
  ctx.fillRect(
    -confetti.width / 2,
    -confetti.height / 2,
    confetti.width,
    confetti.height,
  );

  ctx.restore();
};

const animate = () => {
  if (!ctx || !canvas.value) return;

  // 清除画布，保持透明背景
  ctx.clearRect(0, 0, canvas.value.width, canvas.value.height);

  // 更新和绘制所有彩带
  for (let i = confetti.length - 1; i >= 0; i--) {
    const conf = confetti[i];

    // 更新位置
    conf.x += conf.vx;
    conf.y += conf.vy;
    conf.vy += 0.2; // 重力
    conf.rotation += conf.rotationSpeed;

    // 轻微的左右摆动
    conf.vx += (Math.random() - 0.5) * 0.1;

    // 减少透明度
    conf.opacity -= 0.005;

    // 如果彩带消失或飞出屏幕，则移除
    if (conf.opacity <= 0 || conf.y > canvas.value.height) {
      confetti.splice(i, 1);
      continue;
    }

    drawConfetti(conf);
  }

  // 持续添加新的彩带
  if (Math.random() < 0.1) {
    for (let i = 0; i < 3; i++) {
      confetti.push(createConfetti());
    }
  }

  animationId = requestAnimationFrame(animate);
};

const resizeCanvas = () => {
  if (!canvas.value || !ctx) return;
  canvas.value.width = window.innerWidth;
  canvas.value.height = window.innerHeight;
};

onMounted(() => {
  if (!canvas.value) return;
  ctx = canvas.value.getContext("2d");
  resizeCanvas();
  window.addEventListener("resize", resizeCanvas);

  // 初始发射一批彩带
  for (let i = 0; i < 50; i++) {
    confetti.push(createConfetti());
  }

  animate();
});

onBeforeUnmount(() => {
  window.removeEventListener("resize", resizeCanvas);
  if (animationId) {
    cancelAnimationFrame(animationId);
  }
});

setTimeout(() => {
  shouldFadeOut.value = true;
}, 3000);
</script>
