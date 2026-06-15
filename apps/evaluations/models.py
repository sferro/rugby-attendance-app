from django.db import models

from apps.people.models import PlayerTeam


class PlayerMeasurement(models.Model):
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="measurements",
    )
    measurement_date = models.DateField()
    height_cm = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    weight_kg = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_measurements"
        ordering = ["-measurement_date", "player_team"]

    def __str__(self):
        return f"{self.player_team} - {self.measurement_date}"


class AthleticTestType(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    unit = models.CharField(max_length=50)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "athletic_test_types"
        ordering = ["description"]

    def __str__(self):
        return self.description


class AthleticTestResult(models.Model):
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="athletic_test_results",
    )
    athletic_test_type = models.ForeignKey(
        AthleticTestType,
        on_delete=models.CASCADE,
        related_name="results",
    )
    test_date = models.DateField()
    value = models.DecimalField(max_digits=8, decimal_places=2)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "athletic_test_results"
        ordering = ["-test_date", "player_team"]

    def __str__(self):
        return f"{self.player_team} - {self.athletic_test_type} - {self.test_date}"
    
class EvaluationCategory(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "evaluation_categories"
        ordering = ["description"]

    def __str__(self):
        return self.description


class EvaluationCriteria(models.Model):
    category = models.ForeignKey(
        EvaluationCategory,
        on_delete=models.CASCADE,
        related_name="criteria",
    )
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "evaluation_criteria"
        ordering = ["category", "description"]

    def __str__(self):
        return f"{self.category} - {self.description}"

class PlayerEvaluation(models.Model):
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="evaluations",
    )
    evaluation_date = models.DateField()
    evaluated_by = models.CharField(max_length=100, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_evaluations"
        ordering = ["-evaluation_date", "player_team"]

    def __str__(self):
        return f"{self.player_team} - {self.evaluation_date}"


class PlayerEvaluationItem(models.Model):
    player_evaluation = models.ForeignKey(
        PlayerEvaluation,
        on_delete=models.CASCADE,
        related_name="items",
    )
    evaluation_criteria = models.ForeignKey(
        EvaluationCriteria,
        on_delete=models.CASCADE,
        related_name="evaluation_items",
    )
    score = models.PositiveSmallIntegerField()
    comments = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_evaluation_items"
        ordering = ["player_evaluation", "evaluation_criteria"]

    def __str__(self):
        return f"{self.player_evaluation} - {self.evaluation_criteria}: {self.score}"


class PlayerLevelEvaluation(models.Model):
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="level_evaluations",
    )
    evaluation_date = models.DateField()
    level = models.PositiveSmallIntegerField()
    evaluated_by = models.CharField(max_length=100, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_level_evaluations"
        ordering = ["-evaluation_date", "player_team"]

    def __str__(self):
        return f"{self.player_team} - Nivel {self.level} - {self.evaluation_date}"