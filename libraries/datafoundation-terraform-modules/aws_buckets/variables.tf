variable env { type = string }
variable bucket_name { type = string }

variable "tags" {
  type = map(string)
  default = {}
}

variable special_encrypted {
  type = bool
  default = true
}

variable "versioning" {
  type = string
  validation {
    condition     = contains(["Disabled", "Suspended", "Enabled"], var.versioning)
    error_message = "Allowed values for versioning are \"Disabled\", \"Suspended\", or \"Enabled\"."
  }
  default = "Disabled"
}

variable "acl" {
  type = string
  default = "private"
}

variable "kms_key_policy" {
  type = string
  default = ""
}

variable "cross_account_access" {
  type = list(object({
    sid: string
    account_id: string
    action: list(string)
  }))
  default = []
}

variable "kms_arn" {
  type = string
  default = ""
}

variable "force_destroy" {
  type = bool
  default = false
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}
