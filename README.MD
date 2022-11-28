# Modern data platform
## Setup

- Deploy EKS:

```console
tfenv use 1.1.0
./dataform.sh \
    --layer 00_data_platform \
    --stage 01_data_core_eksy \
    --env staging \
    --cmd apply
```

- deploy dagster foundation :

```console
tfenv 1.3.1
./dataform.sh \
    --layer 00_data_platform \
    --stage 03_dagster_foundation \
    --env staging \
    --cmd apply
```

- Deploy business:

```console
./dataform.sh \
    --layer 01_domain_business \
    --stage 04_dagster \
    --env staging \
    --cmd apply
```

- Deploy product:

```console
./dataform.sh \
    --layer 01_domain_product \
    --stage 04_dagster \
    --env staging \
    --cmd apply
```


- Deploy dagster:

```console
./dataform.sh \
    --layer 00_data_platform \
    --stage 05_dagster_on_eks \
    --env staging \
    --cmd destroy
```

## Clean up

- Remove dagster:

```console
 ./dataform.sh \
    --layer 00_data_platform \
    --stage 05_dagster_on_eks \
    --env staging \
    --cmd destroy
```

- Remove product:

```console
 ./dataform.sh \
    --layer 01_domain_product \
    --stage 04_dagster \
    --env staging \
    --cmd destroy
```

- Remove business:

```console
 ./dataform.sh \
    --layer 01_domain_business \
    --stage 04_dagster \
    --env staging \
    --cmd destroy
```

- Remove dagster foundation :

```console
 ./dataform.sh \
    --layer 00_data_platform \
    --stage 03_dagster_foundation \
    --env staging \
    --cmd destroy
```

- Remove EKS:

```console
tfenv use 1.1.0
 ./dataform.sh \
    --layer 00_data_platform \
    --stage 01_data_core_eksy \
    --env staging \
    --cmd destroy
```

