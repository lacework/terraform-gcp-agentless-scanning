# v2.1.7

## Bug Fixes
* fix: only enforce org_id check for org level integrations (#99) (Joseph Wilder)([39261d8](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/39261d8f610098ec85c53b9b1f49129cd0ce7da2))
## Other Changes
* ci: version bump to v2.1.7-dev (Lacework)([777a678](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/777a6784fa0e451e4621ed6e6bc19f8c1bc2c563))
---
# v2.1.6

## Bug Fixes
* fix(LINK-4116): do not require org level permissions for project level integrations. (#96) (Joseph Wilder)([041b661](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/041b66160bd72297e6f024dd3b256c23835b66cb))
## Other Changes
* ci: version bump to v2.1.6-dev (Lacework)([1b9271b](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/1b9271b29f66826328c9db23606b2b09d3e8c603))
---
# v2.1.5

## Bug Fixes
* fix: update Terraform examples (#94) (Joseph Wilder)([8a28834](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/8a28834527e69f7874ed73bd0d9dcb2dc0a6e911))
## Other Changes
* ci: version bump to v2.1.5-dev (Lacework)([88ddcfc](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/88ddcfc7534228e35280b7020f8bbf52a216e2cf))
---
# v2.1.4

## Bug Fixes
* fix: add get project permission to org snapshot role (#91) (Timothy Nguyen)([9ab4bb5](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/9ab4bb5e1e3db1fdadaa41293673ba30d6396cfc))
## Other Changes
* chore: Set deletion_protection to false for rollback (#92) (Lei Jin)([a423507](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/a4235076e526ef6bc410d22bb832e8de088a73d2))
* ci: version bump to v2.1.4-dev (Lacework)([0d638c6](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/0d638c6a83cfc4af36536061ca3c25541ffad825))
---
# v2.1.3

## Other Changes
* ci: version bump to v2.1.3-dev (Lacework)([87590e9](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/87590e9b5050058b1f37f9482c0934beae479b78))
---
# v2.1.2

## Bug Fixes
* fix: pass integration type to all modules for multi region deployments (#87) (ammarekbote)([038a792](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/038a792a49ed8d7dc125a5863210a1c36b4b7e5d))
## Other Changes
* chore(GROW-2952): add codeowners (#86) (Matt Cadorette)([5376d3d](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/5376d3d516cb38556803bdb29adf9e8a6fe65f21))
* ci: version bump to v2.1.2-dev (Lacework)([c892f2a](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/c892f2a508c0a4945852b1f6ba22e765ecfbc05c))
---
# v2.1.1

## Other Changes
* chore: update version and add org_id in examples (#82) (Ao Zhang)([385f9a1](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/385f9a1b5bab41d9855acf396a1a94e563c60728))
* ci: version bump to v2.1.1-dev (Lacework)([9ce8238](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/9ce823853d189dc6e9d1fa362bb76d3504932c69))
---
# v2.1.0

## Features
* feat(GROW-2928): Add an output to capture Lacework integration GUID (#80) (Lei Jin)([e10ebf2](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e10ebf2acdc307a771d6d583e19e22c814b067fb))
## Other Changes
* ci: version bump to v2.0.1-dev (Lacework)([b36316e](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/b36316e5e1ca0f5e46fb62a01d897c982115bed7))
---
# v2.0.0

## Breaking Changes
* chore: upgrade gcp version requirements (#76) (Ao Zhang)([e6d45eb](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e6d45eb4b826a5d5cdd91392469176fccc31d4ce)) This updates the dependency on provider `lacework/service-account/gcp` from 1.0 to 2.0. 

## Bug Fixes
* fix: use right resource id in project-level intg (#78) (Ao Zhang)([92ae5fe](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/92ae5fecc6a7fa0b00b8bd3ce98b1ba8d895df1e))
## Other Changes
* chore: upgrade gcp version requirements (#76) (Ao Zhang)([e6d45eb](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e6d45eb4b826a5d5cdd91392469176fccc31d4ce))
* ci: version bump to v1.0.1-dev (Lacework)([bf89798](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/bf89798f1a85f333ac33ff7221440beb04c48ca0))
---
# v1.0.0

## Breaking Changes 
* bump TF requirement to 1.5 (Ao Zhang)([17a6d54](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/17a6d54b23fcb071c533cb4ad4361f9c555a2350))

## Other Changes
* ci: version bump to v1.0.0 (Lacework)([40ff1fe](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/40ff1fef3ca98502719315c71a0042e2db27aa69))
---
# v0.3.11

## Other Changes
* ci: version bump to v0.3.11-dev (Lacework)([e8ce417](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e8ce4179d98541b5fcf8ec46109f759ee16f9d5e))
---
# v0.3.10

## Other Changes
* ci: fix typo in nightly workflow (#70) (Timothy MacDonald)([1fac1e0](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/1fac1e0fbe7085504da319b52e945bf053eed76f))
* ci: set minimum TF version for test workflows (#69) (Timothy MacDonald)([b7a38f8](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/b7a38f8d5c330de0865f6477099f347d9d42b333))
* ci: version bump to v0.3.10-dev (Lacework)([bf98f52](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/bf98f52430abe2f5859e9fb9002e86d22f85f631))
---
# v0.3.9

## Other Changes
* ci: version bump to v0.3.9-dev (Lacework)([a5e6b1c](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/a5e6b1c08f2d4c02ff886edb0f278a637685a9cf))
---
# v0.3.8

## Other Changes
* ci: migrate from codefresh to github actions (#62) (Timothy MacDonald)([84b8fef](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/84b8fef68dbc1ce98ca07cc83ac643416159632b))
* ci: version bump to v0.3.8-dev (Lacework)([623d213](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/623d2130fac9776c271231e2d96d83367b8008fa))
---
# v0.3.7

## Other Changes
* ci: version bump to v0.3.7-dev (Lacework)([c42dda2](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/c42dda2ea41713a9bea8e4bee83d00bfff7b4e92))
---
# v0.3.6

## Other Changes
* ci: version bump to v0.3.6-dev (Lacework)([b267be6](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/b267be6f4c4badeb59b36d4f4f303411f05404a4))
---
# v0.3.5

## Bug Fixes
* fix: ensure project_filter_list is read from the global project (#55) (Max Fechner)([ce19866](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/ce19866ea6f65c50bd00cf50a01784e4955e527e))
## Other Changes
* ci: version bump to v0.3.5-dev (Lacework)([ac3eb7b](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/ac3eb7bb5238163d627e72dfe13dfc14defaeb7e))
---
# v0.3.4

## Bug Fixes
* fix: request for projects.get perm (#52) (Ao Zhang)([331a3c0](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/331a3c0f0c40914b9d60cd929cdab6b66d1c7e54))
* fix: add dependency for secret iam on orchestrate account creation (#44) (ammarekbote)([97c3a54](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/97c3a54f466be2412596bc4f503a34c7a48c8427))
## Other Changes
* ci: version bump to v0.3.4-dev (Lacework)([6ef74eb](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/6ef74eb7a4d8fe64e338fe211d61fb6f06465cbd))
---
# v0.3.3

## Other Changes
* chore: set module_name var (#50) (Darren)([5c1e8fd](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/5c1e8fd0e37396008dc678bef4c10febce0b88f4))
* ci: version bump to v0.3.3-dev (Lacework)([262a6da](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/262a6dae657099de96762e58c2af35e5ac899ab8))
---
# v0.3.2

## Documentation Updates
* docs(vars): match bucket_force_destroy description (#30) (Salim Afiune)([1b8d33e](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/1b8d33ec394dd35ebf4df82f134642492575796d))
* docs(readme): add terraform docs automation (#45) (Timothy MacDonald)([dce1532](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/dce153255d7ba7d81b1a8d31d454c18697995a40))
## Other Changes
* chore: add lacework_metric_module datasource (#49) (Darren)([6df4161](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/6df4161d157eb9c8a5d1e39e672179041fba4095))
* ci: version bump to v0.3.2-dev (Lacework)([0e2c883](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/0e2c8836299ff9182028813cb6b5d2b90c1479a1))
---
# v0.3.1

## Bug Fixes
* fix: allow scanner to terminate host compute instance (#26) (Ammar Ekbote) ([3ce8a5f](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/3ce8a5fbc467219c50f4f08bae26ea9e0a5017bb))
* fix: update cloud schedule trigger to be run by orchestrate email (#37) (Ammar Ekbote) ([df07a59](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/df07a599b640f3f9013359d17ee3501f018f1660))
* fix: add permision to derive machine info from monitored projects (#36) (Ammar Ekbote) ([82a035f](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/82a035f0852a1954327cd94ff84d06f8b1018be9))
## Other Changes
* ci: version bump to v0.3.1-dev (Lacework)([c01c61d](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/c01c61ddafc6b4c7cb93e024d22fecea721d0e61))
---
# v0.3.0

## Features
* feat: Add multi volume variable (#34) (Whitney Smith)([8102c70](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/8102c7068b2c1942663188ee8b503d5097912168))
---
# v0.2.2

## Bug Fixes
* fix: avoid asking for project_id when is not needed (#24) (Salim Afiune)([e1a80ac](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e1a80ac227124da41017a0486052201962ce851a))
## Other Changes
* ci: version bump to v0.2.2-dev (Lacework)([9fb223c](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/9fb223cf0260ff9176b5a53d5ce71c20c00ea887))
---
# v0.2.1

## Bug Fixes
* fix: Update tf scan frequency validation (#18) (Whitney Smith)([9277f2d](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/9277f2d1cb28015083476c1e3274f43ffc5dfc02))
## Other Changes
* refactor: move custom role creation to a new file (#19) (Ammar Ekbote)([d52dfca](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/d52dfca11b9064b5164448c4a4082e508071ac5f))
* chore: remove unnecessary permissions (#21) (ammarekbote)([017f38d](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/017f38da476ad4969a47c576a3378c0268dfabc9))
* ci: version bump to v0.2.1-dev (Lacework)([433ea57](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/433ea57ccef445d322f7df0d3ce6b8490de71608))
---
# v0.2.0

## Features
* feat: allow for custom VPC networking (#14) (Alan Nix)([8bfcdf8](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/8bfcdf832ea633dfc6b3e2a4f83bab38cf23a17e))
## Other Changes
* ci: version bump to v0.1.5-dev (Lacework)([5ecb7f7](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/5ecb7f7d34954ba711eba76d49b973e4a5de8ae5))
---
# v0.1.4

## Bug Fixes
* fix: removed prefix from `GCP_ORG_ID` env var (#12) (Alan Nix)([199a419](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/199a419359c8920169c5477a7f82c688970024dd))
* fix: derive bucket name for regional deployments (#11) (Ammar Ekbote)([542b059](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/542b0595575de333218e68cc38e7d2093c796ad8))
## Other Changes
* ci: version bump to v0.1.4-dev (Lacework)([05da03d](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/05da03d9f9143479939e292a2a202c03ae0fb3e5))
---
# v0.1.3

## Bug Fixes
* fix: inherit region from Google provider configuration (#9) (Alan Nix)([e076522](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/e0765222dd5eb6d4b4d74084bb286ac740a28790))
## Other Changes
* ci: version bump to v0.1.3-dev (Lacework)([28094db](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/28094db5389e4c672717f1585c0e8cc89edffc9c))
---
# v0.1.2

## Bug Fixes
* fix: conditionally create the role for snapshot creation (#7) (Alan Nix)([20b23e3](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/20b23e392d95ae946cb2df133d28b5b99c31b173))
## Other Changes
* ci: version bump to v0.1.2-dev (Lacework)([053f820](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/053f82040a12127c30ef3f20ca74e85f0f107c87))
---
# v0.1.1

## Documentation Updates
* docs: updated examples and added project-level multi-region (#5) (Alan Nix)([67e464a](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/67e464a251d734dd9b00348b21276d34a34c5f9e))
## Other Changes
* ci: version bump to v0.1.1-dev (Lacework)([1d53030](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/1d530305b07941fa58462a2b65b001e8da99e596))
---
# v0.1.0

## Features
* feat: GCP agentless scanning terraform module (#1) (Alan Nix)([58638aa](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/58638aa05e2e81d7ae1232f9d3be8e58f496fa94))
## Bug Fixes
* fix: updated project name in release script (#3) (Alan Nix)([52f7b0b](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/52f7b0be8cb275038c0fd3b4350a55957f2185a8))
## Other Changes
* chore: update Lacework provider version to v1 (Sourcegraph)([23c4950](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/23c4950d27b707cf6d5b19fe0e70f6bba441443a))
* chore: update readme (Darren Murray)([059864a](https://github.com/lacework/terraform-gcp-agentless-scanning/commit/059864a60f56a41f0899c73782a7f6b638794029))
---
