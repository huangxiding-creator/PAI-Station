.class final Lcom/google/mlkit/vision/barcode/bundled/internal/zza;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbm;
.source "com.google.mlkit:barcode-scanning@@17.3.0"


# static fields
.field private static final zza:[I

.field private static final zzb:[[D


# instance fields
.field private final zzc:Landroid/content/Context;

.field private final zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;

.field private zze:Lcom/google/android/libraries/barhopper/BarhopperV3;


# direct methods
.method static constructor <clinit>()V
    .locals 38

    const/4 v0, 0x6

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zza:[I

    const/4 v0, 0x2

    new-array v2, v0, [D

    move-object v1, v2

    fill-array-data v2, :array_1

    new-array v3, v0, [D

    move-object v2, v3

    fill-array-data v3, :array_2

    new-array v4, v0, [D

    move-object v3, v4

    fill-array-data v4, :array_3

    new-array v5, v0, [D

    move-object v4, v5

    fill-array-data v5, :array_4

    new-array v6, v0, [D

    move-object v5, v6

    fill-array-data v6, :array_5

    new-array v7, v0, [D

    move-object v6, v7

    fill-array-data v7, :array_6

    new-array v8, v0, [D

    move-object v7, v8

    fill-array-data v8, :array_7

    new-array v9, v0, [D

    move-object v8, v9

    fill-array-data v9, :array_8

    new-array v10, v0, [D

    move-object v9, v10

    fill-array-data v10, :array_9

    new-array v11, v0, [D

    move-object v10, v11

    fill-array-data v11, :array_a

    new-array v12, v0, [D

    move-object v11, v12

    fill-array-data v12, :array_b

    new-array v13, v0, [D

    move-object v12, v13

    fill-array-data v13, :array_c

    new-array v14, v0, [D

    move-object v13, v14

    fill-array-data v14, :array_d

    new-array v15, v0, [D

    move-object v14, v15

    fill-array-data v15, :array_e

    new-array v15, v0, [D

    move-object/from16 v16, v15

    fill-array-data v16, :array_f

    move-object/from16 v37, v1

    new-array v1, v0, [D

    move-object/from16 v16, v1

    fill-array-data v1, :array_10

    new-array v1, v0, [D

    move-object/from16 v17, v1

    fill-array-data v1, :array_11

    new-array v1, v0, [D

    move-object/from16 v18, v1

    fill-array-data v1, :array_12

    new-array v1, v0, [D

    move-object/from16 v19, v1

    fill-array-data v1, :array_13

    new-array v1, v0, [D

    move-object/from16 v20, v1

    fill-array-data v1, :array_14

    new-array v1, v0, [D

    move-object/from16 v21, v1

    fill-array-data v1, :array_15

    new-array v1, v0, [D

    move-object/from16 v22, v1

    fill-array-data v1, :array_16

    new-array v1, v0, [D

    move-object/from16 v23, v1

    fill-array-data v1, :array_17

    new-array v1, v0, [D

    move-object/from16 v24, v1

    fill-array-data v1, :array_18

    new-array v1, v0, [D

    move-object/from16 v25, v1

    fill-array-data v1, :array_19

    new-array v1, v0, [D

    move-object/from16 v26, v1

    fill-array-data v1, :array_1a

    new-array v1, v0, [D

    move-object/from16 v27, v1

    fill-array-data v1, :array_1b

    new-array v1, v0, [D

    move-object/from16 v28, v1

    fill-array-data v1, :array_1c

    new-array v1, v0, [D

    move-object/from16 v29, v1

    fill-array-data v1, :array_1d

    new-array v1, v0, [D

    move-object/from16 v30, v1

    fill-array-data v1, :array_1e

    new-array v1, v0, [D

    move-object/from16 v31, v1

    fill-array-data v1, :array_1f

    new-array v1, v0, [D

    move-object/from16 v32, v1

    fill-array-data v1, :array_20

    new-array v1, v0, [D

    move-object/from16 v33, v1

    fill-array-data v1, :array_21

    new-array v1, v0, [D

    move-object/from16 v34, v1

    fill-array-data v1, :array_22

    new-array v1, v0, [D

    move-object/from16 v35, v1

    fill-array-data v1, :array_23

    new-array v0, v0, [D

    move-object/from16 v36, v0

    fill-array-data v0, :array_24

    move-object/from16 v1, v37

    filled-new-array/range {v1 .. v36}, [[D

    move-result-object v0

    sput-object v0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzb:[[D

    return-void

    :array_0
    .array-data 4
        0x5
        0x7
        0x7
        0x7
        0x5
        0x5
    .end array-data

    :array_1
    .array-data 8
        0x3fb3333333333333L    # 0.075
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_2
    .array-data 8
        0x3fb999999999999aL    # 0.1
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_3
    .array-data 8
        0x3fc0000000000000L    # 0.125
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_4
    .array-data 8
        0x3fc999999999999aL    # 0.2
        0x4000000000000000L    # 2.0
    .end array-data

    :array_5
    .array-data 8
        0x3fc999999999999aL    # 0.2
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_6
    .array-data 8
        0x3fc3333333333333L    # 0.15
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_7
    .array-data 8
        0x3fc999999999999aL    # 0.2
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_8
    .array-data 8
        0x3fd0000000000000L    # 0.25
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_9
    .array-data 8
        0x3fd6666666666666L    # 0.35
        0x4000000000000000L    # 2.0
    .end array-data

    :array_a
    .array-data 8
        0x3fd6666666666666L    # 0.35
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_b
    .array-data 8
        0x3fd6666666666666L    # 0.35
        0x4008000000000000L    # 3.0
    .end array-data

    :array_c
    .array-data 8
        0x3fd6666666666666L    # 0.35
        0x3fd554c985f06f69L    # 0.3333
    .end array-data

    :array_d
    .array-data 8
        0x3fd3333333333333L    # 0.3
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_e
    .array-data 8
        0x3fd999999999999aL    # 0.4
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_f
    .array-data 8
        0x3fe0000000000000L    # 0.5
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_10
    .array-data 8
        0x3fe0000000000000L    # 0.5
        0x4000000000000000L    # 2.0
    .end array-data

    :array_11
    .array-data 8
        0x3fe0000000000000L    # 0.5
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_12
    .array-data 8
        0x3fe0000000000000L    # 0.5
        0x4008000000000000L    # 3.0
    .end array-data

    :array_13
    .array-data 8
        0x3fe0000000000000L    # 0.5
        0x3fd554c985f06f69L    # 0.3333
    .end array-data

    :array_14
    .array-data 8
        0x3fe3333333333333L    # 0.6
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_15
    .array-data 8
        0x3fe999999999999aL    # 0.8
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_16
    .array-data 8
        0x3ff0000000000000L    # 1.0
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_17
    .array-data 8
        0x3fe4cccccccccccdL    # 0.65
        0x4000000000000000L    # 2.0
    .end array-data

    :array_18
    .array-data 8
        0x3fe4cccccccccccdL    # 0.65
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_19
    .array-data 8
        0x3fe4cccccccccccdL    # 0.65
        0x4008000000000000L    # 3.0
    .end array-data

    :array_1a
    .array-data 8
        0x3fe4cccccccccccdL    # 0.65
        0x3fd554c985f06f69L    # 0.3333
    .end array-data

    :array_1b
    .array-data 8
        0x3ff0000000000000L    # 1.0
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_1c
    .array-data 8
        0x3fe999999999999aL    # 0.8
        0x4000000000000000L    # 2.0
    .end array-data

    :array_1d
    .array-data 8
        0x3fe999999999999aL    # 0.8
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_1e
    .array-data 8
        0x3fe999999999999aL    # 0.8
        0x4008000000000000L    # 3.0
    .end array-data

    :array_1f
    .array-data 8
        0x3fe999999999999aL    # 0.8
        0x3fd554c985f06f69L    # 0.3333
    .end array-data

    :array_20
    .array-data 8
        0x3ff0000000000000L    # 1.0
        0x3ff0000000000000L    # 1.0
    .end array-data

    :array_21
    .array-data 8
        0x3fee666666666666L    # 0.95
        0x4000000000000000L    # 2.0
    .end array-data

    :array_22
    .array-data 8
        0x3fee666666666666L    # 0.95
        0x3fe0000000000000L    # 0.5
    .end array-data

    :array_23
    .array-data 8
        0x3fee666666666666L    # 0.95
        0x4008000000000000L    # 3.0
    .end array-data

    :array_24
    .array-data 8
        0x3fee666666666666L    # 0.95
        0x3fd554c985f06f69L    # 0.3333
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbm;-><init>()V

    iput-object p1, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzc:Landroid/content/Context;

    iput-object p2, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;

    return-void
.end method

.method private final zzg()Lcom/google/android/libraries/barhopper/RecognitionOptions;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/libraries/barhopper/RecognitionOptions;

    invoke-direct {v0}, Lcom/google/android/libraries/barhopper/RecognitionOptions;-><init>()V

    iget-object v1, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;->zza()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setBarcodeFormats(I)V

    iget-object v1, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;

    .line 2
    invoke-virtual {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;->zzb()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setOutputUnrecognizedBarcodes(Z)V

    .line 3
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setEnableQrAlignmentGrid(Z)V

    .line 4
    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setEnableUseKeypointAsFinderPattern(Z)V

    return-object v0
.end method

.method private static zzh(Lcom/google/photos/vision/barhopper/zzl;Ljava/lang/String;Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;
    .locals 10

    .line 1
    const/4 v0, 0x0

    if-eqz p0, :cond_2

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {p2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    .line 2
    new-instance p2, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zzf()I

    move-result v2

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zzd()I

    move-result v3

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zza()I

    move-result v4

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zzb()I

    move-result v5

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zzc()I

    move-result v6

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zze()I

    move-result v7

    invoke-virtual {p0}, Lcom/google/photos/vision/barhopper/zzl;->zzj()Z

    move-result v8

    .line 3
    invoke-virtual {p1}, Ljava/util/regex/Matcher;->find()Z

    move-result p0

    if-eqz p0, :cond_1

    const/4 p0, 0x1

    invoke-virtual {p1, p0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    :cond_1
    move-object v9, v0

    move-object v1, p2

    invoke-direct/range {v1 .. v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;-><init>(IIIIIIZLjava/lang/String;)V

    return-object p2

    .line 1
    :cond_2
    :goto_0
    return-object v0
.end method

.method private final zzi(Ljava/nio/ByteBuffer;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/libraries/barhopper/BarhopperV3;

    .line 2
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzd()I

    move-result v1

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zza()I

    move-result p2

    .line 4
    invoke-virtual {v0, v1, p2, p1, p3}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognize(IILjava/nio/ByteBuffer;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->arrayOffset()I

    move-result v1

    if-nez v1, :cond_1

    .line 9
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzd()I

    move-result v1

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zza()I

    move-result p2

    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object p1

    .line 10
    invoke-virtual {v0, v1, p2, p1, p3}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognize(II[BLcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    goto :goto_0

    .line 6
    :cond_1
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    new-array v1, v1, [B

    .line 7
    invoke-virtual {p1, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 8
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzd()I

    move-result p1

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zza()I

    move-result p2

    invoke-virtual {v0, p1, p2, v1, p3}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognize(II[BLcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object p1

    .line 4
    :goto_0
    return-object p1
.end method

.method private final zzj(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Ljava/util/List;
    .locals 48

    .line 1
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzb()I

    move-result v3

    const/4 v4, 0x0

    sparse-switch v3, :sswitch_data_0

    .line 5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    .line 124
    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzb()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Unsupported image format: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2
    :sswitch_0
    invoke-static/range {p1 .. p1}, Lcom/google/android/gms/dynamic/ObjectWrapper;->unwrap(Lcom/google/android/gms/dynamic/IObjectWrapper;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/media/Image;

    .line 3
    invoke-static {v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/media/Image;

    invoke-virtual {v3}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object v3

    aget-object v3, v3, v4

    invoke-virtual {v3}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 4
    invoke-direct {v0, v3, v1, v2}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzi(Ljava/nio/ByteBuffer;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object v2

    goto :goto_0

    .line 5
    :sswitch_1
    invoke-static/range {p1 .. p1}, Lcom/google/android/gms/dynamic/ObjectWrapper;->unwrap(Lcom/google/android/gms/dynamic/IObjectWrapper;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/nio/ByteBuffer;

    invoke-direct {v0, v3, v1, v2}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzi(Ljava/nio/ByteBuffer;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object v2

    goto :goto_0

    .line 124
    :sswitch_2
    iget-object v3, v0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    .line 6
    invoke-static {v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/google/android/libraries/barhopper/BarhopperV3;

    invoke-static/range {p1 .. p1}, Lcom/google/android/gms/dynamic/ObjectWrapper;->unwrap(Lcom/google/android/gms/dynamic/IObjectWrapper;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/graphics/Bitmap;

    invoke-virtual {v3, v5, v2}, Lcom/google/android/libraries/barhopper/BarhopperV3;->recognize(Landroid/graphics/Bitmap;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;

    move-result-object v2

    .line 4
    :goto_0
    new-instance v3, Ljava/util/ArrayList;

    .line 7
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 8
    invoke-static {}, Lcom/google/mlkit/vision/common/internal/ImageUtils;->getInstance()Lcom/google/mlkit/vision/common/internal/ImageUtils;

    move-result-object v5

    .line 9
    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzd()I

    move-result v6

    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zza()I

    move-result v7

    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzc()I

    move-result v8

    .line 10
    invoke-virtual {v5, v6, v7, v8}, Lcom/google/mlkit/vision/common/internal/ImageUtils;->getUprightRotationMatrix(III)Landroid/graphics/Matrix;

    move-result-object v5

    .line 11
    invoke-virtual {v2}, Lcom/google/photos/vision/barhopper/BarhopperProto$BarhopperResponse;->zzc()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_18

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/google/photos/vision/barhopper/zzc;

    .line 12
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zza()I

    move-result v7

    const/16 v8, 0x8

    const/4 v9, 0x1

    if-lez v7, :cond_1

    if-eqz v5, :cond_1

    new-array v7, v8, [F

    .line 13
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzo()Ljava/util/List;

    move-result-object v10

    .line 14
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zza()I

    move-result v11

    move v12, v4

    :goto_2
    if-ge v12, v11, :cond_0

    .line 15
    invoke-interface {v10, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/google/photos/vision/barhopper/zzaf;

    invoke-virtual {v13}, Lcom/google/photos/vision/barhopper/zzaf;->zza()I

    move-result v13

    int-to-float v13, v13

    add-int v14, v12, v12

    aput v13, v7, v14

    add-int/2addr v14, v9

    .line 16
    invoke-interface {v10, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/google/photos/vision/barhopper/zzaf;

    invoke-virtual {v13}, Lcom/google/photos/vision/barhopper/zzaf;->zzb()I

    move-result v13

    int-to-float v13, v13

    aput v13, v7, v14

    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    .line 17
    :cond_0
    invoke-virtual {v5, v7}, Landroid/graphics/Matrix;->mapPoints([F)V

    .line 18
    invoke-virtual/range {p2 .. p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;->zzc()I

    move-result v10

    move v12, v4

    :goto_3
    if-ge v12, v11, :cond_2

    .line 19
    invoke-virtual {v6}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;->zzH()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;

    move-result-object v6

    check-cast v6, Lcom/google/photos/vision/barhopper/zzb;

    add-int v13, v12, v10

    rem-int/2addr v13, v11

    add-int v14, v12, v12

    .line 20
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzaf;->zzc()Lcom/google/photos/vision/barhopper/zzae;

    move-result-object v15

    aget v8, v7, v14

    float-to-int v8, v8

    .line 21
    invoke-virtual {v15, v8}, Lcom/google/photos/vision/barhopper/zzae;->zza(I)Lcom/google/photos/vision/barhopper/zzae;

    add-int/2addr v14, v9

    aget v8, v7, v14

    float-to-int v8, v8

    .line 22
    invoke-virtual {v15, v8}, Lcom/google/photos/vision/barhopper/zzae;->zzb(I)Lcom/google/photos/vision/barhopper/zzae;

    .line 23
    invoke-virtual {v15}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    move-result-object v8

    check-cast v8, Lcom/google/photos/vision/barhopper/zzaf;

    .line 24
    invoke-virtual {v6, v13, v8}, Lcom/google/photos/vision/barhopper/zzb;->zza(ILcom/google/photos/vision/barhopper/zzaf;)Lcom/google/photos/vision/barhopper/zzb;

    .line 25
    invoke-virtual {v6}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    move-result-object v6

    check-cast v6, Lcom/google/photos/vision/barhopper/zzc;

    add-int/lit8 v12, v12, 0x1

    const/16 v8, 0x8

    goto :goto_3

    .line 78
    :cond_1
    nop

    .line 26
    :cond_2
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzt()Z

    move-result v7

    const/4 v8, -0x1

    if-eqz v7, :cond_3

    .line 27
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzh()Lcom/google/photos/vision/barhopper/zzv;

    move-result-object v7

    .line 28
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;

    .line 29
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzv;->zzf()I

    move-result v12

    add-int/2addr v12, v8

    .line 30
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzv;->zzc()Ljava/lang/String;

    move-result-object v13

    .line 31
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzv;->zze()Ljava/lang/String;

    move-result-object v14

    .line 32
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzv;->zzd()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v11, v12, v13, v14, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v22, v11

    goto :goto_4

    .line 78
    :cond_3
    const/16 v22, 0x0

    .line 33
    :goto_4
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzv()Z

    move-result v7

    if-eqz v7, :cond_4

    .line 34
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzb()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;

    move-result-object v7

    .line 35
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;

    invoke-virtual {v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;->zzd()I

    move-result v12

    add-int/2addr v12, v8

    invoke-virtual {v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;->zzc()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v11, v12, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;-><init>(ILjava/lang/String;)V

    move-object/from16 v23, v11

    goto :goto_5

    .line 78
    :cond_4
    const/16 v23, 0x0

    .line 36
    :goto_5
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzw()Z

    move-result v7

    if-eqz v7, :cond_5

    .line 37
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzj()Lcom/google/photos/vision/barhopper/zzah;

    move-result-object v7

    .line 38
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzav;

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzah;->zzc()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzah;->zzd()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v11, v12, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzav;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v24, v11

    goto :goto_6

    .line 78
    :cond_5
    const/16 v24, 0x0

    .line 39
    :goto_6
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzy()Z

    move-result v7

    if-eqz v7, :cond_6

    .line 40
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzl()Lcom/google/photos/vision/barhopper/zzao;

    move-result-object v7

    .line 41
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzax;

    .line 42
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzao;->zzd()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzao;->zzc()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzao;->zze()I

    move-result v7

    add-int/2addr v7, v8

    invoke-direct {v11, v12, v13, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzax;-><init>(Ljava/lang/String;Ljava/lang/String;I)V

    move-object/from16 v25, v11

    goto :goto_7

    .line 78
    :cond_6
    const/16 v25, 0x0

    .line 43
    :goto_7
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzx()Z

    move-result v7

    if-eqz v7, :cond_7

    .line 44
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzk()Lcom/google/photos/vision/barhopper/zzak;

    move-result-object v7

    .line 45
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaw;

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzak;->zzc()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzak;->zzd()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v11, v12, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaw;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v26, v11

    goto :goto_8

    .line 78
    :cond_7
    const/16 v26, 0x0

    .line 46
    :goto_8
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzu()Z

    move-result v7

    if-eqz v7, :cond_8

    .line 47
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzi()Lcom/google/photos/vision/barhopper/zzz;

    move-result-object v7

    .line 48
    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzas;

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzz;->zza()D

    move-result-wide v12

    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzz;->zzb()D

    move-result-wide v14

    invoke-direct {v11, v12, v13, v14, v15}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzas;-><init>(DD)V

    move-object/from16 v27, v11

    goto :goto_9

    .line 78
    :cond_8
    const/16 v27, 0x0

    .line 49
    :goto_9
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzq()Z

    move-result v7

    if-eqz v7, :cond_b

    .line 50
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzd()Lcom/google/photos/vision/barhopper/zzn;

    move-result-object v7

    .line 51
    new-instance v19, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzao;

    .line 52
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zzj()Ljava/lang/String;

    move-result-object v12

    .line 53
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zze()Ljava/lang/String;

    move-result-object v13

    .line 54
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zzf()Ljava/lang/String;

    move-result-object v14

    .line 55
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zzh()Ljava/lang/String;

    move-result-object v15

    .line 56
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zzi()Ljava/lang/String;

    move-result-object v16

    .line 57
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zzb()Lcom/google/photos/vision/barhopper/zzl;

    move-result-object v11

    .line 58
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzn()Z

    move-result v17

    if-eqz v17, :cond_9

    .line 59
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzt()Ljava/lang/String;

    move-result-object v17

    move-object/from16 v9, v17

    goto :goto_a

    .line 78
    :cond_9
    const/4 v9, 0x0

    .line 59
    :goto_a
    nop

    .line 60
    const-string v10, "DTSTART:([0-9TZ]*)"

    invoke-static {v11, v9, v10}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzh(Lcom/google/photos/vision/barhopper/zzl;Ljava/lang/String;Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;

    move-result-object v17

    .line 61
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzn;->zza()Lcom/google/photos/vision/barhopper/zzl;

    move-result-object v7

    .line 62
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v9

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzn()Z

    move-result v9

    if-eqz v9, :cond_a

    .line 63
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v9

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzt()Ljava/lang/String;

    move-result-object v9

    goto :goto_b

    .line 78
    :cond_a
    const/4 v9, 0x0

    .line 63
    :goto_b
    nop

    .line 64
    const-string v10, "DTEND:([0-9TZ]*)"

    invoke-static {v7, v9, v10}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzh(Lcom/google/photos/vision/barhopper/zzl;Ljava/lang/String;Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;

    move-result-object v18

    move-object/from16 v11, v19

    invoke-direct/range {v11 .. v18}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzao;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzan;)V

    move-object/from16 v28, v19

    goto :goto_c

    .line 78
    :cond_b
    const/16 v28, 0x0

    .line 65
    :goto_c
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzr()Z

    move-result v7

    if-eqz v7, :cond_13

    .line 66
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zze()Lcom/google/photos/vision/barhopper/zzp;

    move-result-object v7

    .line 67
    new-instance v17, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzap;

    .line 68
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;

    move-result-object v9

    if-eqz v9, :cond_c

    .line 69
    new-instance v10, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzat;

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzd()Ljava/lang/String;

    move-result-object v30

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzi()Ljava/lang/String;

    move-result-object v31

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzh()Ljava/lang/String;

    move-result-object v32

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzc()Ljava/lang/String;

    move-result-object v33

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzf()Ljava/lang/String;

    move-result-object v34

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zze()Ljava/lang/String;

    move-result-object v35

    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzck;->zzj()Ljava/lang/String;

    move-result-object v36

    .line 70
    move-object/from16 v29, v10

    invoke-direct/range {v29 .. v36}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzat;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_d

    .line 78
    :cond_c
    const/4 v10, 0x0

    .line 71
    :goto_d
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zzd()Ljava/lang/String;

    move-result-object v11

    .line 72
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zze()Ljava/lang/String;

    move-result-object v12

    .line 73
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zzi()Ljava/util/List;

    move-result-object v9

    .line 74
    invoke-interface {v9}, Ljava/util/List;->isEmpty()Z

    move-result v13

    if-eqz v13, :cond_d

    const/4 v13, 0x0

    goto :goto_f

    .line 75
    :cond_d
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v13

    new-array v13, v13, [Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;

    move v14, v4

    .line 76
    :goto_e
    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v15

    if-ge v14, v15, :cond_e

    .line 77
    new-instance v15, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;

    .line 78
    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;

    invoke-virtual/range {v16 .. v16}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;->zzd()I

    move-result v16

    add-int/lit8 v4, v16, -0x1

    invoke-interface {v9, v14}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;

    invoke-virtual/range {v16 .. v16}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzco;->zzc()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v15, v4, v8}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;-><init>(ILjava/lang/String;)V

    aput-object v15, v13, v14

    add-int/lit8 v14, v14, 0x1

    const/4 v4, 0x0

    const/4 v8, -0x1

    goto :goto_e

    :cond_e
    nop

    .line 79
    :goto_f
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zzh()Ljava/util/List;

    move-result-object v4

    .line 80
    invoke-interface {v4}, Ljava/util/List;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_f

    move-object/from16 v32, v2

    const/4 v14, 0x0

    goto :goto_11

    .line 81
    :cond_f
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v8

    new-array v8, v8, [Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;

    const/4 v9, 0x0

    .line 82
    :goto_10
    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v14

    if-ge v9, v14, :cond_10

    .line 83
    new-instance v14, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;

    .line 84
    invoke-interface {v4, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lcom/google/photos/vision/barhopper/zzv;

    invoke-virtual {v15}, Lcom/google/photos/vision/barhopper/zzv;->zzf()I

    move-result v15

    const/16 v16, -0x1

    add-int/lit8 v15, v15, -0x1

    .line 85
    invoke-interface {v4, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lcom/google/photos/vision/barhopper/zzv;

    invoke-virtual/range {v16 .. v16}, Lcom/google/photos/vision/barhopper/zzv;->zzc()Ljava/lang/String;

    move-result-object v0

    .line 86
    invoke-interface {v4, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lcom/google/photos/vision/barhopper/zzv;

    invoke-virtual/range {v16 .. v16}, Lcom/google/photos/vision/barhopper/zzv;->zze()Ljava/lang/String;

    move-result-object v1

    .line 87
    invoke-interface {v4, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Lcom/google/photos/vision/barhopper/zzv;

    move-object/from16 v32, v2

    invoke-virtual/range {v16 .. v16}, Lcom/google/photos/vision/barhopper/zzv;->zzd()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v14, v15, v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;-><init>(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    aput-object v14, v8, v9

    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, p2

    move-object/from16 v2, v32

    goto :goto_10

    :cond_10
    move-object/from16 v32, v2

    move-object v14, v8

    .line 88
    :goto_11
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zzj()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/String;

    invoke-interface {v0, v2}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    move-object v15, v0

    check-cast v15, [Ljava/lang/String;

    .line 89
    invoke-virtual {v7}, Lcom/google/photos/vision/barhopper/zzp;->zzf()Ljava/util/List;

    move-result-object v0

    .line 90
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_11

    const/4 v9, 0x0

    const/16 v16, 0x0

    goto :goto_13

    .line 91
    :cond_11
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzam;

    const/4 v2, 0x0

    .line 92
    :goto_12
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    if-ge v2, v4, :cond_12

    .line 93
    new-instance v4, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzam;

    .line 94
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;

    invoke-virtual {v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;->zzc()I

    move-result v7

    const/4 v8, -0x1

    add-int/2addr v7, v8

    .line 95
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;

    invoke-virtual {v8}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzci;->zzb()Ljava/util/List;

    move-result-object v8

    move-object/from16 v16, v0

    const/4 v9, 0x0

    new-array v0, v9, [Ljava/lang/String;

    invoke-interface {v8, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    invoke-direct {v4, v7, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzam;-><init>(I[Ljava/lang/String;)V

    aput-object v4, v1, v2

    add-int/lit8 v2, v2, 0x1

    move-object/from16 v0, v16

    goto :goto_12

    :cond_12
    const/4 v9, 0x0

    move-object/from16 v16, v1

    .line 89
    :goto_13
    move v0, v9

    move-object/from16 v9, v17

    invoke-direct/range {v9 .. v16}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzap;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzat;Ljava/lang/String;Ljava/lang/String;[Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;[Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;[Ljava/lang/String;[Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzam;)V

    move-object/from16 v29, v17

    goto :goto_14

    .line 78
    :cond_13
    move-object/from16 v32, v2

    move v0, v4

    const/16 v29, 0x0

    .line 96
    :goto_14
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzs()Z

    move-result v1

    if-eqz v1, :cond_14

    .line 97
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzf()Lcom/google/photos/vision/barhopper/zzr;

    move-result-object v1

    .line 98
    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaq;

    .line 99
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzi()Ljava/lang/String;

    move-result-object v34

    .line 100
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzk()Ljava/lang/String;

    move-result-object v35

    .line 101
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzq()Ljava/lang/String;

    move-result-object v36

    .line 102
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzo()Ljava/lang/String;

    move-result-object v37

    .line 103
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzl()Ljava/lang/String;

    move-result-object v38

    .line 104
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zze()Ljava/lang/String;

    move-result-object v39

    .line 105
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzc()Ljava/lang/String;

    move-result-object v40

    .line 106
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzd()Ljava/lang/String;

    move-result-object v41

    .line 107
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzf()Ljava/lang/String;

    move-result-object v42

    .line 108
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzp()Ljava/lang/String;

    move-result-object v43

    .line 109
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzm()Ljava/lang/String;

    move-result-object v44

    .line 110
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzj()Ljava/lang/String;

    move-result-object v45

    .line 111
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzh()Ljava/lang/String;

    move-result-object v46

    .line 112
    invoke-virtual {v1}, Lcom/google/photos/vision/barhopper/zzr;->zzn()Ljava/lang/String;

    move-result-object v47

    move-object/from16 v33, v2

    invoke-direct/range {v33 .. v47}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaq;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v30, v2

    goto :goto_15

    .line 122
    :cond_14
    const/16 v30, 0x0

    .line 113
    :goto_15
    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzay;

    .line 114
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzz()I

    move-result v2

    const/4 v4, -0x1

    add-int/2addr v2, v4

    const/4 v4, 0x4

    const/4 v7, 0x2

    packed-switch v2, :pswitch_data_0

    const/16 v16, -0x1

    goto :goto_17

    .line 122
    :pswitch_0
    const/16 v2, 0x1000

    goto :goto_16

    :pswitch_1
    const/16 v2, 0x800

    goto :goto_16

    :pswitch_2
    const/16 v2, 0x400

    goto :goto_16

    :pswitch_3
    const/16 v2, 0x200

    goto :goto_16

    :pswitch_4
    const/16 v2, 0x100

    goto :goto_16

    :pswitch_5
    const/16 v2, 0x80

    goto :goto_16

    :pswitch_6
    const/16 v2, 0x40

    goto :goto_16

    :pswitch_7
    const/16 v2, 0x20

    goto :goto_16

    :pswitch_8
    const/16 v2, 0x10

    :goto_16
    move/from16 v16, v2

    goto :goto_17

    :pswitch_9
    const/16 v16, 0x8

    goto :goto_17

    :pswitch_a
    move/from16 v16, v4

    goto :goto_17

    :pswitch_b
    move/from16 v16, v7

    goto :goto_17

    :pswitch_c
    const/16 v16, 0x1

    goto :goto_17

    :pswitch_d
    move/from16 v16, v0

    .line 115
    :goto_17
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzn()Ljava/lang/String;

    move-result-object v17

    .line 116
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzn()Z

    move-result v2

    if-eqz v2, :cond_15

    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzt()Ljava/lang/String;

    move-result-object v2

    goto :goto_18

    .line 122
    :cond_15
    const/4 v2, 0x0

    .line 117
    :goto_18
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzm()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v8

    invoke-virtual {v8}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzw()[B

    move-result-object v19

    .line 118
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzo()Ljava/util/List;

    move-result-object v8

    .line 119
    invoke-interface {v8}, Ljava/util/List;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_16

    const/16 v20, 0x0

    goto :goto_1a

    .line 120
    :cond_16
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v9

    new-array v10, v9, [Landroid/graphics/Point;

    move v9, v0

    .line 121
    :goto_19
    invoke-interface {v8}, Ljava/util/List;->size()I

    move-result v11

    if-ge v9, v11, :cond_17

    new-instance v11, Landroid/graphics/Point;

    .line 122
    invoke-interface {v8, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lcom/google/photos/vision/barhopper/zzaf;

    invoke-virtual {v12}, Lcom/google/photos/vision/barhopper/zzaf;->zza()I

    move-result v12

    invoke-interface {v8, v9}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/google/photos/vision/barhopper/zzaf;

    invoke-virtual {v13}, Lcom/google/photos/vision/barhopper/zzaf;->zzb()I

    move-result v13

    invoke-direct {v11, v12, v13}, Landroid/graphics/Point;-><init>(II)V

    aput-object v11, v10, v9

    add-int/lit8 v9, v9, 0x1

    goto :goto_19

    :cond_17
    move-object/from16 v20, v10

    .line 123
    :goto_1a
    invoke-virtual {v6}, Lcom/google/photos/vision/barhopper/zzc;->zzA()I

    move-result v6

    const/4 v8, -0x1

    add-int/2addr v6, v8

    packed-switch v6, :pswitch_data_1

    move/from16 v21, v0

    goto :goto_1c

    .line 113
    :pswitch_e
    const/16 v8, 0xc

    goto :goto_1b

    :pswitch_f
    const/16 v8, 0xb

    goto :goto_1b

    :pswitch_10
    const/16 v8, 0xa

    goto :goto_1b

    :pswitch_11
    const/16 v8, 0x9

    goto :goto_1b

    :pswitch_12
    const/16 v21, 0x8

    goto :goto_1c

    :pswitch_13
    const/4 v8, 0x7

    goto :goto_1b

    :pswitch_14
    const/4 v8, 0x6

    goto :goto_1b

    :pswitch_15
    const/4 v8, 0x5

    goto :goto_1b

    :pswitch_16
    move/from16 v21, v4

    goto :goto_1c

    :pswitch_17
    const/4 v8, 0x3

    :goto_1b
    move/from16 v21, v8

    goto :goto_1c

    :pswitch_18
    move/from16 v21, v7

    goto :goto_1c

    :pswitch_19
    const/16 v21, 0x1

    .line 123
    :goto_1c
    move-object v15, v1

    move-object/from16 v18, v2

    invoke-direct/range {v15 .. v30}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzay;-><init>(ILjava/lang/String;Ljava/lang/String;[B[Landroid/graphics/Point;ILcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzar;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzau;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzav;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzax;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaw;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzas;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzao;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzap;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzaq;)V

    .line 113
    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    move-object/from16 v1, p2

    move v4, v0

    move-object/from16 v2, v32

    move-object/from16 v0, p0

    goto/16 :goto_1

    .line 78
    :cond_18
    return-object v3

    :sswitch_data_0
    .sparse-switch
        -0x1 -> :sswitch_2
        0x11 -> :sswitch_1
        0x23 -> :sswitch_0
        0x32315659 -> :sswitch_1
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
    .end packed-switch
.end method


# virtual methods
.method public final zzb(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;)Ljava/util/List;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzg()Lcom/google/android/libraries/barhopper/RecognitionOptions;

    move-result-object v0

    .line 2
    invoke-direct {p0, p1, p2, v0}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzj(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public final zzc(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;)Ljava/util/List;
    .locals 3

    .line 1
    invoke-direct {p0}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzg()Lcom/google/android/libraries/barhopper/RecognitionOptions;

    move-result-object v0

    new-instance v1, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;

    invoke-direct {v1}, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;-><init>()V

    .line 2
    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;->zzc()[F

    move-result-object v2

    .line 3
    invoke-virtual {v1, v2}, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->setExtraScales([F)V

    .line 4
    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;->zza()I

    move-result v2

    .line 5
    invoke-virtual {v1, v2}, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->setMinimumDetectedDimension(I)V

    .line 6
    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;->zzb()Z

    move-result v2

    .line 7
    invoke-virtual {v1, v2}, Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;->setSkipProcessingIfBarcodeFound(Z)V

    .line 8
    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setMultiScaleDecodingOptions(Lcom/google/android/libraries/barhopper/MultiScaleDecodingOptions;)V

    new-instance v1, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;

    invoke-direct {v1}, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;-><init>()V

    .line 9
    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;->zza()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;

    move-result-object v2

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbt;->zzc()[F

    move-result-object v2

    .line 10
    invoke-virtual {v1, v2}, Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;->setExtraScales([F)V

    .line 11
    invoke-virtual {v0, v1}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setMultiScaleDetectionOptions(Lcom/google/android/libraries/barhopper/MultiScaleDetectionOptions;)V

    .line 12
    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbc;->zzb()Z

    move-result p3

    .line 13
    invoke-virtual {v0, p3}, Lcom/google/android/libraries/barhopper/RecognitionOptions;->setQrEnableFourthCornerApproximation(Z)V

    .line 14
    invoke-direct {p0, p1, p2, v0}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzj(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzcc;Lcom/google/android/libraries/barhopper/RecognitionOptions;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method public final zzd()V
    .locals 13

    .line 1
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    if-eqz v0, :cond_0

    goto/16 :goto_2

    :cond_0
    new-instance v0, Lcom/google/android/libraries/barhopper/BarhopperV3;

    invoke-direct {v0}, Lcom/google/android/libraries/barhopper/BarhopperV3;-><init>()V

    iput-object v0, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    .line 2
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzi;->zza()Lcom/google/barhopper/deeplearning/zzh;

    move-result-object v0

    .line 3
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzf;->zza()Lcom/google/barhopper/deeplearning/zze;

    move-result-object v1

    const/4 v2, 0x0

    const/16 v3, 0x10

    move v4, v2

    move v5, v4

    :goto_0
    const/4 v6, 0x6

    if-ge v4, v6, :cond_2

    .line 4
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzc;->zza()Lcom/google/barhopper/deeplearning/zzb;

    move-result-object v6

    .line 5
    invoke-virtual {v6, v3}, Lcom/google/barhopper/deeplearning/zzb;->zzc(I)Lcom/google/barhopper/deeplearning/zzb;

    .line 6
    invoke-virtual {v6, v3}, Lcom/google/barhopper/deeplearning/zzb;->zzd(I)Lcom/google/barhopper/deeplearning/zzb;

    move v7, v2

    :goto_1
    sget-object v8, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zza:[I

    .line 7
    aget v8, v8, v4

    if-ge v7, v8, :cond_1

    sget-object v8, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzb:[[D

    .line 8
    aget-object v8, v8, v5

    aget-wide v9, v8, v2

    const-wide/high16 v11, 0x4074000000000000L    # 320.0

    mul-double/2addr v9, v11

    .line 9
    const/4 v11, 0x1

    aget-wide v11, v8, v11

    .line 10
    invoke-static {v11, v12}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v11

    double-to-float v8, v11

    double-to-float v9, v9

    div-float v10, v9, v8

    .line 11
    invoke-virtual {v6, v10}, Lcom/google/barhopper/deeplearning/zzb;->zza(F)Lcom/google/barhopper/deeplearning/zzb;

    mul-float/2addr v9, v8

    .line 12
    invoke-virtual {v6, v9}, Lcom/google/barhopper/deeplearning/zzb;->zzb(F)Lcom/google/barhopper/deeplearning/zzb;

    add-int/lit8 v5, v5, 0x1

    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_1
    add-int/2addr v3, v3

    .line 13
    invoke-virtual {v1, v6}, Lcom/google/barhopper/deeplearning/zze;->zza(Lcom/google/barhopper/deeplearning/zzb;)Lcom/google/barhopper/deeplearning/zze;

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 14
    :cond_2
    invoke-virtual {v0, v1}, Lcom/google/barhopper/deeplearning/zzh;->zza(Lcom/google/barhopper/deeplearning/zze;)Lcom/google/barhopper/deeplearning/zzh;

    :try_start_0
    iget-object v1, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzc:Landroid/content/Context;

    .line 15
    invoke-virtual {v1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    const-string v2, "mlkit_barcode_models/barcode_ssd_mobilenet_v1_dmp25_quant.tflite"

    invoke-virtual {v1, v2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v2, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzc:Landroid/content/Context;

    .line 16
    invoke-virtual {v2}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    const-string v3, "mlkit_barcode_models/oned_auto_regressor_mobile.tflite"

    invoke-virtual {v2, v3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :try_start_2
    iget-object v3, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzc:Landroid/content/Context;

    .line 17
    invoke-virtual {v3}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    const-string v4, "mlkit_barcode_models/oned_feature_extractor_mobile.tflite"

    invoke-virtual {v3, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    :try_start_3
    iget-object v4, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    .line 18
    invoke-static {v4}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/google/android/libraries/barhopper/BarhopperV3;

    .line 19
    invoke-static {}, Lcom/google/barhopper/deeplearning/BarhopperV3Options;->zza()Lcom/google/barhopper/deeplearning/zzk;

    move-result-object v5

    .line 20
    invoke-static {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzs(Ljava/io/InputStream;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v6

    invoke-virtual {v0, v6}, Lcom/google/barhopper/deeplearning/zzh;->zzb(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;)Lcom/google/barhopper/deeplearning/zzh;

    .line 21
    invoke-virtual {v5, v0}, Lcom/google/barhopper/deeplearning/zzk;->zza(Lcom/google/barhopper/deeplearning/zzh;)Lcom/google/barhopper/deeplearning/zzk;

    .line 22
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzac;->zza()Lcom/google/barhopper/deeplearning/zzab;

    move-result-object v0

    .line 23
    invoke-static {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzs(Ljava/io/InputStream;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v6

    invoke-virtual {v0, v6}, Lcom/google/barhopper/deeplearning/zzab;->zza(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;)Lcom/google/barhopper/deeplearning/zzab;

    .line 24
    invoke-static {v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;->zzs(Ljava/io/InputStream;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;

    move-result-object v6

    invoke-virtual {v0, v6}, Lcom/google/barhopper/deeplearning/zzab;->zzb(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;)Lcom/google/barhopper/deeplearning/zzab;

    .line 25
    invoke-virtual {v5, v0}, Lcom/google/barhopper/deeplearning/zzk;->zzb(Lcom/google/barhopper/deeplearning/zzab;)Lcom/google/barhopper/deeplearning/zzk;

    .line 26
    invoke-virtual {v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    move-result-object v0

    check-cast v0, Lcom/google/barhopper/deeplearning/BarhopperV3Options;

    .line 27
    invoke-virtual {v4, v0}, Lcom/google/android/libraries/barhopper/BarhopperV3;->create(Lcom/google/barhopper/deeplearning/BarhopperV3Options;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v3, :cond_3

    .line 28
    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    :cond_3
    if-eqz v2, :cond_4

    :try_start_5
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    :cond_4
    if-eqz v1, :cond_5

    :try_start_6
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0

    return-void

    .line 1
    :cond_5
    :goto_2
    return-void

    .line 15
    :catchall_0
    move-exception v0

    if-eqz v3, :cond_6

    :try_start_7
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v3

    :try_start_8
    invoke-virtual {v0, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_6
    :goto_3
    throw v0
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    :catchall_2
    move-exception v0

    if-eqz v2, :cond_7

    :try_start_9
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_3

    goto :goto_4

    :catchall_3
    move-exception v2

    :try_start_a
    invoke-virtual {v0, v2}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_7
    :goto_4
    throw v0
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_4

    .line 29
    :catchall_4
    move-exception v0

    if-eqz v1, :cond_8

    .line 15
    :try_start_b
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    goto :goto_5

    :catchall_5
    move-exception v1

    :try_start_c
    invoke-virtual {v0, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_8
    :goto_5
    throw v0
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_0

    .line 28
    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/IllegalStateException;

    .line 29
    const-string v2, "Failed to open Barcode models"

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public final zze(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbe;)V
    .locals 0

    .line 1
    invoke-virtual {p0}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zzd()V

    return-void
.end method

.method public final zzf()V
    .locals 1

    .line 1
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/google/android/libraries/barhopper/BarhopperV3;->close()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;->zze:Lcom/google/android/libraries/barhopper/BarhopperV3;

    :cond_0
    return-void
.end method
