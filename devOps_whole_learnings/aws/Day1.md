# AWS IAM Core Concepts

These are fundamental components of AWS Identity and Access Management (IAM) used to securely control access to AWS resources.

---

## 1. IAM Users

An **IAM User** represents an individual (person or application) that interacts with AWS.

### It contains:
- Username
- Password (for AWS Console)
- Access Keys (for CLI/API)

### Key Points:
- Permissions are not assigned by default
- Must attach policies or add to groups
- Avoid using root account

---

## 2. IAM Groups

An **IAM Group** is a collection of IAM users with shared permissions.

### It provides:
- Centralized permission management
- Easier access control for multiple users

### Example:
- Developers → EC2 + S3 access
- Admins → Full access

---

## 3. IAM Roles

An **IAM Role** is an identity with temporary credentials that can be assumed by users or AWS services.

### Key Features:
- No long-term credentials
- Provides temporary security credentials
- Assumed when needed

### Common Use Cases:
- EC2 accessing S3
- Cross-account access
- Federated login (SSO)

---

## 4. IAM Policies

An **IAM Policy** is a JSON document that defines permissions.

### Structure:
~~~json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-bucket/*"
}
~~~

### Key Elements:
- Effect → Allow / Deny
- Action → What actions are allowed
- Resource → On which resource

---

## 5. Managed vs Inline Policies

### Managed Policies

Reusable policies that can be attached to multiple users, groups, or roles.

#### Types:
- AWS Managed Policies (predefined)
- Customer Managed Policies

---

### Inline Policies

Policies directly attached to a single user, group, or role.

### Key Points:
- Not reusable
- Used for specific use cases
- Harder to manage at scale

---

## 6. Multi-Factor Authentication (MFA)

MFA adds an extra layer of security beyond passwords.

### Types:
- Virtual MFA (Authenticator apps)
- Hardware MFA devices

### Best Practice:
- Enable MFA for root account
- Enable MFA for admin users

---

## 7. Access Keys

Access keys are used for programmatic access (CLI, SDK, API).

### Components:
- Access Key ID
- Secret Access Key

### Best Practices:
- Do not hardcode keys in code
- Rotate keys regularly
- Prefer IAM roles over access keys

---

## 8. Principle of Least Privilege

Grant only the permissions required to perform a task.

### Bad Example:
~~~json
{
  "Action": "*",
  "Resource": "*"
}
~~~

### Good Example:
~~~json
{
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-bucket/*"
}
~~~

---

## How It All Works Together

- Users → Assigned to Groups
- Groups → Attached with Policies
- Roles → Provide temporary access
- Policies → Define permissions
- MFA → Secures access
- Access Keys → Enable CLI/API usage


## About Action and Resource

A Resource is the target on which an action is allowed or denied.

👉 Think of it like:

- Action → What you can do
- Resource → Where you can do it

### Example:
~~~json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-bucket/*"
}
~~~

### Explanation:
- Action → Read objects
- Resource → Only inside my-bucket
- Effect → Permission is allowed

### 🧠 What is ARN (Amazon Resource Name)?
Resources are defined using ARN (Amazon Resource Name).

- Format
```bash
arn:partition:service:region:account-id:resource
```
---

## Best Practices

- Avoid using root account
- Use IAM roles instead of access keys
- Enable MFA wherever possible
- Follow least privilege principle
- Use groups for managing permissions
- Prefer managed policies over inline

---

## Summary

IAM helps you:
- Secure AWS resources
- Control access effectively
- Implement strong security practices
