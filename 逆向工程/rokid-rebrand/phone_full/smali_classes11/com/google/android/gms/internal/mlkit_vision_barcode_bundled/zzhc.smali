.class final Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhc;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhb;
.source "com.google.mlkit:barcode-scanning@@17.3.0"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhb;-><init>()V

    return-void
.end method


# virtual methods
.method final zza(I[BII)I
    .locals 11

    .line 1
    const/16 v0, -0x13

    const/16 v1, -0x3e

    const/16 v2, -0x10

    const/4 v3, 0x0

    const/16 v4, -0x60

    const/16 v5, -0x20

    const/16 v6, -0x41

    const/4 v7, -0x1

    if-eqz p1, :cond_e

    if-lt p3, p4, :cond_0

    return p1

    :cond_0
    int-to-byte v8, p1

    if-ge v8, v5, :cond_2

    if-lt v8, v1, :cond_1

    add-int/lit8 p1, p3, 0x1

    aget-byte p3, p2, p3

    if-gt p3, v6, :cond_1

    move p3, p1

    goto/16 :goto_3

    .line 13
    :cond_1
    return v7

    :cond_2
    shr-int/lit8 v9, p1, 0x8

    not-int v9, v9

    if-ge v8, v2, :cond_8

    int-to-byte p1, v9

    if-nez p1, :cond_4

    add-int/lit8 p1, p3, 0x1

    .line 2
    aget-byte p3, p2, p3

    if-ge p1, p4, :cond_3

    move v10, p3

    move p3, p1

    move p1, v10

    goto :goto_0

    .line 4
    :cond_3
    invoke-static {v8, p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhe;->zza(II)I

    move-result p1

    return p1

    .line 2
    :cond_4
    :goto_0
    if-gt p1, v6, :cond_7

    if-ne v8, v5, :cond_5

    if-lt p1, v4, :cond_7

    :cond_5
    if-ne v8, v0, :cond_6

    if-ge p1, v4, :cond_7

    :cond_6
    add-int/lit8 p1, p3, 0x1

    .line 3
    aget-byte p3, p2, p3

    if-gt p3, v6, :cond_7

    move p3, p1

    goto :goto_3

    :cond_7
    return v7

    .line 4
    :cond_8
    int-to-byte v9, v9

    if-nez v9, :cond_a

    add-int/lit8 p1, p3, 0x1

    .line 5
    aget-byte v9, p2, p3

    if-ge p1, p4, :cond_9

    move p3, p1

    move p1, v3

    goto :goto_1

    .line 6
    :cond_9
    invoke-static {v8, v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhe;->zza(II)I

    move-result p1

    return p1

    :cond_a
    shr-int/lit8 p1, p1, 0x10

    .line 5
    :goto_1
    if-nez p1, :cond_c

    add-int/lit8 p1, p3, 0x1

    .line 7
    aget-byte p3, p2, p3

    if-ge p1, p4, :cond_b

    move v10, p3

    move p3, p1

    move p1, v10

    goto :goto_2

    .line 16
    :cond_b
    invoke-static {v8, v9, p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhe;->zzb(III)I

    move-result p1

    return p1

    .line 7
    :cond_c
    :goto_2
    if-gt v9, v6, :cond_d

    shl-int/lit8 v8, v8, 0x1c

    add-int/lit8 v9, v9, 0x70

    add-int/2addr v8, v9

    shr-int/lit8 v8, v8, 0x1e

    if-nez v8, :cond_d

    if-gt p1, v6, :cond_d

    add-int/lit8 p1, p3, 0x1

    .line 8
    aget-byte p3, p2, p3

    if-gt p3, v6, :cond_d

    move p3, p1

    goto :goto_3

    :cond_d
    return v7

    .line 1
    :cond_e
    :goto_3
    if-ge p3, p4, :cond_f

    .line 9
    aget-byte p1, p2, p3

    if-ltz p1, :cond_f

    add-int/lit8 p3, p3, 0x1

    goto :goto_3

    :cond_f
    if-lt p3, p4, :cond_10

    :goto_4
    goto/16 :goto_6

    :cond_10
    :goto_5
    if-lt p3, p4, :cond_11

    goto :goto_4

    :cond_11
    add-int/lit8 p1, p3, 0x1

    .line 10
    aget-byte p3, p2, p3

    if-gez p3, :cond_1c

    if-ge p3, v5, :cond_14

    if-lt p1, p4, :cond_12

    move v3, p3

    goto :goto_6

    :cond_12
    if-lt p3, v1, :cond_13

    add-int/lit8 p3, p1, 0x1

    .line 11
    aget-byte p1, p2, p1

    if-le p1, v6, :cond_10

    :cond_13
    move v3, v7

    goto :goto_6

    :cond_14
    if-ge p3, v2, :cond_19

    add-int/lit8 v8, p4, -0x1

    if-lt p1, v8, :cond_15

    .line 14
    invoke-static {p2, p1, p4}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhe;->zzc([BII)I

    move-result v3

    goto :goto_6

    :cond_15
    add-int/lit8 v8, p1, 0x1

    .line 12
    aget-byte p1, p2, p1

    if-gt p1, v6, :cond_18

    if-ne p3, v5, :cond_16

    if-lt p1, v4, :cond_18

    :cond_16
    if-ne p3, v0, :cond_17

    if-ge p1, v4, :cond_18

    :cond_17
    add-int/lit8 p3, v8, 0x1

    aget-byte p1, p2, v8

    if-le p1, v6, :cond_10

    :cond_18
    move v3, v7

    goto :goto_6

    :cond_19
    add-int/lit8 v8, p4, -0x2

    if-lt p1, v8, :cond_1a

    .line 15
    invoke-static {p2, p1, p4}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzhe;->zzc([BII)I

    move-result v3

    goto :goto_6

    :cond_1a
    add-int/lit8 v8, p1, 0x1

    .line 13
    aget-byte p1, p2, p1

    if-gt p1, v6, :cond_1b

    shl-int/lit8 p3, p3, 0x1c

    add-int/lit8 p1, p1, 0x70

    add-int/2addr p3, p1

    shr-int/lit8 p1, p3, 0x1e

    if-nez p1, :cond_1b

    add-int/lit8 p1, v8, 0x1

    aget-byte p3, p2, v8

    if-gt p3, v6, :cond_1b

    add-int/lit8 p3, p1, 0x1

    aget-byte p1, p2, p1

    if-le p1, v6, :cond_10

    :cond_1b
    move v3, v7

    .line 9
    :goto_6
    return v3

    .line 13
    :cond_1c
    move p3, p1

    goto :goto_5
.end method
