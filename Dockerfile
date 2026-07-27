# 1. Base Image: Pin version for consistent & predictable builds
FROM oven/bun:1-slim AS base

# 2. Working Directory: Standard directory for app code inside container
WORKDIR /app

# 3. Environment Variables
ENV NODE_ENV=production \
    PORT=3000

# 4. Dependency Caching: Copy only lock/package files first
COPY package.json bun.lock* ./

# 5. Install Dependencies (frozen lockfile for production stability)
RUN bun install --frozen-lockfile --production

# 6. Copy Application Source Code (uses .dockerignore to skip unwanted files)
COPY . .

# 7. Run as non-root user for container security
USER bun

# 8. Document exposed port
EXPOSE 3000

# 9. Default start command
CMD ["bun", "run", "index.ts"]











# ----------------------------------------------------
# Stage 1: Build the compiled binary
# ----------------------------------------------------
#FROM oven/bun:1 AS builder
#WORKDIR /app

#COPY package.json bun.lock* ./
#RUN bun install --frozen-lockfile

#COPY . .
# Compile TypeScript + Express into a single binary 'myapp'
#RUN bun build --compile --minify ./index.ts --outfile myapp

# ----------------------------------------------------
# Stage 2: Minimal Runtime Image (Super fast & small!)
# ----------------------------------------------------
#FROM oven/bun:1-slim AS runner
#WORKDIR /app

#ENV NODE_ENV=production \
#    PORT=3000

# Copy ONLY the compiled binary from Stage 1! 
# (No node_modules, no package.json, no source code needed!)
#COPY --from=builder /app/myapp ./myapp

#USER bun
#EXPOSE 3000

#CMD ["./myapp"]
