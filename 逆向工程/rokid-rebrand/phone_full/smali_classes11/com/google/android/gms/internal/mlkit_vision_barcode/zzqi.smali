.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.1"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field public static final enum zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

.field private static final synthetic zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;


# instance fields
.field private final zzl:I


# direct methods
.method static constructor <clinit>()V
    .locals 13

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    const-string v1, "UNKNOWN_FORMAT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 2
    const-string v1, "NV16"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 3
    const-string v1, "NV21"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 4
    const-string v1, "YV12"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 5
    const-string v1, "YUV_420_888"

    const/4 v2, 0x4

    const/4 v3, 0x7

    invoke-direct {v0, v1, v2, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 6
    const-string v1, "JPEG"

    const/4 v4, 0x5

    const/16 v5, 0x8

    invoke-direct {v0, v1, v4, v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 7
    const-string v1, "BITMAP"

    const/4 v6, 0x6

    invoke-direct {v0, v1, v6, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 8
    const-string v1, "CM_SAMPLE_BUFFER_REF"

    invoke-direct {v0, v1, v3, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 9
    const-string v1, "UI_IMAGE"

    invoke-direct {v0, v1, v5, v6}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    .line 10
    const-string v1, "CV_PIXEL_BUFFER_REF"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v4, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v5, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v6, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v7, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v8, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v11, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    sget-object v12, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    filled-new-array/range {v3 .. v12}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzl:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;
    .locals 1

    .line 1
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzk:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzqi;->zzl:I

    return v0
.end method
