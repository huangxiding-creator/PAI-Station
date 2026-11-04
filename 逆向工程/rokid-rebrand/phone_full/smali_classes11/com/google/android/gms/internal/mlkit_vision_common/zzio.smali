.class public final enum Lcom/google/android/gms/internal/mlkit_vision_common/zzio;
.super Ljava/lang/Enum;
.source "com.google.mlkit:vision-common@@17.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_common/zzag;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

.field private static final synthetic zzg:[Lcom/google/android/gms/internal/mlkit_vision_common/zzio;


# instance fields
.field private final zzh:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    const-string v1, "SOURCE_UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zza:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    .line 2
    const-string v1, "BITMAP"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzb:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    .line 3
    const-string v1, "BYTEARRAY"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzc:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    .line 4
    const-string v1, "BYTEBUFFER"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzd:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    .line 5
    const-string v1, "FILEPATH"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zze:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    .line 6
    const-string v1, "ANDROID_MEDIA_IMAGE"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzf:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v3, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zza:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v4, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzb:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v5, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzc:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v6, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzd:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v7, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zze:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    sget-object v8, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzf:Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    filled-new-array/range {v3 .. v8}, [Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzg:[Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzh:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_common/zzio;
    .locals 1

    .line 1
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzg:[Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_common/zzio;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_common/zzio;->zzh:I

    return v0
.end method
