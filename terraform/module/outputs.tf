output "ecr_repository_worker_endpoint" {
  value = aws_ecr_repository.worker.repository_url
}

output "load_balancer_ip" {
  value = aws_lb.main.dns_name
}