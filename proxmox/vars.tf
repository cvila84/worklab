variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDURcfem6gvMcjxYln8lO589XCNIYpjvXwS6d0rbq1zUQcxMjA2n7emZtu/UKvhCgelucbPCZrcRcf2apAUg5IWsP/viZSiDlf01pY6sq8lDX2o/JjnbZSsdg6/xdQeHoy48rVfNM5rdDk+SDaEQ6yIzNXr42lZGvpLyPLr/TC8uU7u9w3voqSROYm7cO0djY3j7HimlcQegbO7Nqm0AL1iiEX2nxVz9BuPsBNmHqjlZS4wtN6w7MrRCe+zrc/tSBQJcTV+739AEYBvRQM0xnBlzm0Xly0kNMkG+QINRVQJALdFoZa2Y334kKH/AwZGQ3CZvb1dsoQ+3vNBlTRgS7D8BoLHQy5cNgs+1Dlhq4JxbY/Okr3mg8hXnBVbALZja6KFuIt/cqiHhTDkjU1A+6O2oPgdHYjvtwr5LBWOrGKyYBPidI/NteakLF3OJhgC+lbFRNcCc1z5E9fVGkwvie2ipeMTHrih23OZS8LVqzRNzGe4/rMHwC+th0ehjEoyb8U= root@pve1"
}

variable "password" {
  type = string
  default = "krissfr"
}

variable "host" {
  type = string
  default = "pve.home"
}

variable "node" {
  type = string
  default = "pve"
}
