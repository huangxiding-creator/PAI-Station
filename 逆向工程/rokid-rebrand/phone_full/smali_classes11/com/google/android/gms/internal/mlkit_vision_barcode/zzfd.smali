.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.1"


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

.field private static final synthetic zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    const-string v1, "DEFAULT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    .line 2
    const-string v1, "SIGNED"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    .line 3
    const-string v1, "FIXED"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    sget-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    filled-new-array {v0, v1, v2}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;
    .locals 1

    .line 1
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->zzd:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfd;

    return-object v0
.end method
