.class public final enum Lcom/google/android/gms/internal/mlkit_common/zzne;
.super Ljava/lang/Enum;
.source "com.google.mlkit:common@@18.11.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_common/zzba;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzg:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzh:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzi:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzj:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field public static final enum zzk:Lcom/google/android/gms/internal/mlkit_common/zzne;

.field private static final synthetic zzl:[Lcom/google/android/gms/internal/mlkit_common/zzne;


# instance fields
.field private final zzm:I


# direct methods
.method static constructor <clinit>()V
    .locals 14

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    const-string v1, "TYPE_UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zza:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 2
    const-string v1, "CUSTOM"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 3
    const-string v1, "AUTOML_IMAGE_LABELING"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 4
    const-string v1, "BASE_TRANSLATE"

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 5
    const-string v1, "CUSTOM_OBJECT_DETECTION"

    const/4 v2, 0x4

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zze:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 6
    const-string v1, "CUSTOM_IMAGE_LABELING"

    const/4 v2, 0x5

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzf:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 7
    const-string v1, "BASE_ENTITY_EXTRACTION"

    const/4 v2, 0x6

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzg:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 8
    const-string v1, "BASE_DIGITAL_INK"

    const/4 v2, 0x7

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzh:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 9
    const-string v1, "TOXICITY_DETECTION"

    const/16 v2, 0x8

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzi:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 10
    const-string v1, "IMAGE_CAPTIONING"

    const/16 v2, 0x9

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzj:Lcom/google/android/gms/internal/mlkit_common/zzne;

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzne;

    .line 11
    const-string v1, "DIGITAL_INK_SEGMENTATION"

    const/16 v2, 0xa

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzne;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzk:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v3, Lcom/google/android/gms/internal/mlkit_common/zzne;->zza:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v4, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v5, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v6, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v7, Lcom/google/android/gms/internal/mlkit_common/zzne;->zze:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v8, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzf:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v9, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzg:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v10, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzh:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v11, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzi:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v12, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzj:Lcom/google/android/gms/internal/mlkit_common/zzne;

    sget-object v13, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzk:Lcom/google/android/gms/internal/mlkit_common/zzne;

    filled-new-array/range {v3 .. v13}, [Lcom/google/android/gms/internal/mlkit_common/zzne;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzl:[Lcom/google/android/gms/internal/mlkit_common/zzne;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzm:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_common/zzne;
    .locals 1

    .line 1
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzl:[Lcom/google/android/gms/internal/mlkit_common/zzne;

    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_common/zzne;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_common/zzne;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzne;->zzm:I

    return v0
.end method
